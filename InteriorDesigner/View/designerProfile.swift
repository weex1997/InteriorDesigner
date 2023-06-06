//
//  Home.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 23/05/2023.
//

import SwiftUI
import FirebaseAuth

struct designerProfile: View {
    var size: CGSize
    var safeArea: EdgeInsets
    @StateObject var viewModel = ViewModel()
    @State var userIDE = Auth.auth().currentUser?.uid

    var body: some View {
    
            // NavigationView{
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
                
                Button {
                    print("Edit")
                    
                } label: {
                    Image("Pen")
                }
                
                .frame(width: 700,height: 150)
            }
            .ignoresSafeArea(.all, edges: .top)
        }
        

        
    @ViewBuilder
    func HeaderView( ) -> some View {
        let headerHeight = (size.height * 0.3) + safeArea .top
        let minimumHeaderHeight = 65 + safeArea.top
        
        GeometryReader { _ in
            
            ZStack {
                Rectangle()
                    .fill (Color("Primary").gradient)
                
                
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
                    Text (self.viewModel.user.name ?? "Best Designer")
                        .font (.title)
                        .fontWeight (.bold)
                        .foregroundColor (.white)
                    Text(self.viewModel.user.styles ?? "Modern , Classic")
                        .foregroundColor (.white)
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(self.viewModel.user.rate ?? "4.5")
                            .foregroundColor(.white)
                    }
                    
                }
                .padding (.top, safeArea.top)
                .padding (.bottom)
            }
            .frame (height: headerHeight)
            // .offset(y: -offsetY)
            
        }
        .frame (height: headerHeight)
        .onAppear(){
            self.viewModel.getData(id: userIDE ?? "123")
        }
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
