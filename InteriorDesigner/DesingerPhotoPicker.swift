import SwiftUI
import PhotosUI

struct DesingerPhotoPicker: View {
    
    @State private var image = UIImage()
    @State private var showSheet = false
    @State var images : [UIImage] = []
    @StateObject var viewModel = ViewModel()

    var body: some View {
//        ScrollView(.horizontal) {
//            LazyHStack {
//                HStack {
//                    ForEach(images, id: \.self) { image in
//                        Image(uiImage: image)
//                            .resizable()
//                            .frame(width: 100 ,height: 100)
//
//                    }
//
//
//                }
//
//            }
//        }
        HStack{
            ScrollView(.horizontal) {
                LazyHStack {
                    HStack {
                        ForEach(viewModel.user.images, id: \.self) { item in
                            AsyncImage(url: URL(string: "\(item)"))
                            { image in
                                image
                                    .resizable()
                                //                                        .aspectRatio(contentMode: .fill)
                                
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 100 ,height: 100)
                        }
                        
                    }
                    
                }
            }.frame(height: 100)
                .padding(.leading)
                Image(systemName: "plus")
                    .font(.headline)
                    .frame(maxWidth: 100)
                    .frame(height: 100)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                //                .opacity(0.5)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    .padding(.trailing)
                    .onTapGesture {
                        showSheet = true
                    }
                    .sheet(isPresented: $showSheet,onDismiss: {
                        viewModel.upload(image: image)
//                        images.append(image)
                    }) {
                        // Pick an image from the photo library:
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        //  If you wish to take a photo from camera instead:
                        // ImagePicker(sourceType: .camera, selectedImage: self.$image)
                    }
           
        }
           
    }
}

struct DesingerPhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        DesingerPhotoPicker()
    }
}
