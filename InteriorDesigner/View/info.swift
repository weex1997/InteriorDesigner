//
//  info.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 24/05/2023.
//

import SwiftUI
import PhotosUI
import FirebaseAuth

struct info: View {
    @State var userIDE = Auth.auth().currentUser?.uid
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @StateObject var viewModel = ViewModel()

    var body: some View {
        //Spacer()
        
        VStack{
            Spacer()
            VStack{
                Text("About Me")
                    .font(.title)
                    .foregroundColor(Color("Primary"))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
                
                Text(self.viewModel.user.brief ?? "uyyyuuuyyyuyuuy")
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
                Spacer()
            }
            VStack{
                Text("Styles")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Primary"))
                    .bold()
                    .padding(5)
                Text(self.viewModel.user.styles ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
            }
            
            VStack{
                Text("Field")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Primary"))
                    .bold()
                    .padding(5)
                HStack{
                    ZStack{
                        
                        
                        Capsule()
                            .fill(Color("Primary"))
                            .frame(width: 80, height: 28)
//                        Text(self.viewModel.user.field ?? [""])
                            
                    } .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                    
                    ZStack{
                        Capsule()
                            .fill(Color("Primary"))
                            .frame(width: 80, height: 28)
//                        Text(self.viewModel.user.field ?? ["hoo"])
                         
                    } .padding(.leading,-260)
                }
                VStack{
                    Text("Protofolio")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("Primary"))
                        .bold()
                        .padding(5)
                        .padding(.trailing,00)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            Image("Im")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            Image("Im1")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            Image("Im2")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            
                            Image("Im")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            Image("Im1")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            Image("Im2")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                                .padding(5)
                        }
                        Spacer()
                            .padding(.bottom)
                            
                           
                    }
                }
            }

                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Button(action: {viewModel.updateData(id: self.viewModel.user.id) }) {
                            Text("Upload")
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: 150,height: 50)
                            
                        }
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Primary"))
                            .frame(width: 330, height: 48.58))
                        
                      Spacer()
                    }
                    .padding(.leading, 90.0)
                    .frame(width: 330, height: 48.58)
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            // Retrieve selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120.0, height:120)
                        .clipShape(Circle())
                        .frame(width: 400, height: 200)
                    //                    .padding(.top,-10)
                    //                    .padding(.bottom,-10)
                }
            
//                Button(action: { }) {
//                    Text("Upload")
//                        .bold()
//                        .foregroundColor(.white)
//                        .frame(width: 150,height: 50)
//                }
//                .background(RoundedRectangle(cornerRadius: 8)
//
//                    .fill(Color("Primary"))
//                    .frame(width: 330, height: 48.58))
//
//              Spacer()
//         //   VStack{
//                Text(" * JPEG, PNG,  Pdf ( Max size : 5M )")
//                    .padding(.bottom,20)
//                    .padding(.trailing,60)
          //  }
            Text(" * JPEG, PNG ( Max size : 5M )")
                .padding(.bottom,20)
                .padding(.trailing,60)
            
            Button(action: { }) {
                Text("Log out")
                    .bold()
                    .foregroundColor(Color("Re"))
            }
            .background(RoundedRectangle(cornerRadius: 8)
                        
                .stroke(Color("Re"), lineWidth: 2)
                        
                .frame(width: 330, height: 48.58)
            )
            Spacer()
            
        } .padding(20)
            .onAppear(){
                self.viewModel.getData(id: userIDE ?? "123")
            }
            
    }
}
    struct info_Previews: PreviewProvider {
        static var previews: some View {
            info()
        }
    }
