import SwiftUI

struct Home: View {
    
    var size: CGSize
    var safeArea: EdgeInsets
  //  @State private var showImage : Bool = false
    
    var body: some View {
      //  NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    HeaderView()
                    info()
                    // SampleCardsView()
                        .zIndex(1000)
                }
                .background {
                    ScrollDetector { offset in
                        print(offset)
                        
                    } onDraggingEnd: { offset, velocity in
                        
                    }
                }
            }
            ZStack{
     
//                Button {
//                    print("UserProfile()")
//
//                } label: {
//                    Image("Pen")
//                }
//
//
//                Button(action: UserProfile) {
//                    Image("Pen")
//                        .padding()
//                }
        
                
                Button(
                    action:
                        {
                            UserProfile()
                        }
                    , label: {
                        Image("Pen")
                    }
                )
                .frame(width: 700,height: 150)
            }
     //   }
    }
    @ViewBuilder
    func HeaderView( ) -> some View {
        let headerHeight = (size.height * 0.3) + safeArea .top
        let minimumHeaderHeight = 65 + safeArea.top
        
        GeometryReader { _ in
            
            ZStack {
                Rectangle()
                    .fill (Color("Pr").gradient)
                
                
                VStack(spacing: 15) {
                    
                    GeometryReader {
                        let rect = $0.frame (in: .global)
                        Image ("b")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame (width: rect.width, height: rect.height)
                            .clipShape (Circle ())
                    }
                    .frame (width: headerHeight * 0.5, height: headerHeight * 0.5)
                    Text ("Prifile Designer")
                        .font (.title)
                        .fontWeight (.bold)
                        .foregroundColor (.white)
                    Text("Modren , Classic")
                        .foregroundColor (.white)
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4.5")
                            .foregroundColor(.white)
                    }
                    
                }
                .padding (.top, safeArea.top)
                .padding (.bottom)
            }
            .frame (height: headerHeight)
//             .offset(y: -offsetY)
            
        }
        .frame (height: headerHeight)
    }
    @ViewBuilder
    func SampleCardsView() -> some View {
        VStack(spacing: 15) {
            ForEach(1...25, id: \.self) { _ in
                RoundedRectangle (cornerRadius: 10, style: .continuous)
                    .fill(.black.opacity (0.05))
                    .frame (height: 75)
            }
        }
        .padding(15)
        
    }
    
    
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
