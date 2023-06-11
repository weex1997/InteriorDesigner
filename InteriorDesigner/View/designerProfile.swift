//
//  Home.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 23/05/2023.
//

import SwiftUI

struct designerProfile: View {
    
    var size: CGSize
    var safeArea: EdgeInsets
    @State var goToEdit = false
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
                NavigationLink(destination: UserProfile().navigationBarBackButtonHidden(false), isActive: $goToEdit){}
                
                VStack(spacing: -30) {
                    
                    VStack{
                        HeaderView()
                        VStack(alignment: .trailing){
                            Button {
                                goToEdit = true
                                
                            } label: {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("line"))
                                
                            }
                        }.offset(x: 160 , y: -60)
                    }
                    .frame (height: 420)

                    VStack{
                        info()
                        // SampleCardsView()
                        //                        .zIndex(1000)
                    }
                }
                .background {
                    ScrollDetector { offset in
                        print(offset)
                        
                    } onDraggingEnd: { offset, velocity in
                        
                    }
                }
            }
        }
            .onAppear(){
                self.viewModel.getData()
            }
//        ZStack{
//
//            Button {
//                print("Edit")
//
//            } label: {
//                Image("Pen")
//            }
//
//            .frame(width: 700,height: 150)
//        }

    }
    struct HeaderView : View {
      
        @StateObject var viewModel = ViewModel()

//        GeometryReader { _ in
        var body: some View {
            
            ZStack {
                Rectangle()
                    .fill (Color("Primary").gradient)
                
                
                VStack(spacing: 10) {
                    
                    ZStack{
                        if (self.viewModel.user.gender == "1") {
                            Circle()
                                .foregroundColor(Color("light"))
                            
                            Image ("male").resizable().aspectRatio(contentMode: .fill).clipShape (Circle ())
                        }
                        else {
                            Circle()
                                .foregroundColor(Color("light"))
                            
                            Image ("Female").resizable().aspectRatio(contentMode: .fill).clipShape (Circle ())
                        }
                        //                            .padding(.trailing,-200)
                        
                    }.frame(width: 130 , height: 130)                   
                    .padding(.top, 70)
                    VStack(spacing: 10){
                        VStack{
                            Text (self.viewModel.user.name ?? "Best Designer")
                                .font (.title)
                                .fontWeight (.bold)
                                .foregroundColor (.white)
                        }
                        VStack{
                            Text(self.viewModel.user.styles ?? "Modren , Classic")
                                .foregroundColor (.white)
                        }
                        VStack{
                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text("4.5")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                }
            }                    .edgesIgnoringSafeArea(.top)
                    .onAppear(){
                        self.viewModel.getData()
                    }
            // .offset(y: -offsetY)
            
            //        }
            //        .frame (height: 350)
        }
    }
//    @ViewBuilder
//    func SampleCardsView() -> some View {
//        VStack(spacing: 15) {
//            ForEach(1...25, id: \.self) { _ in
//                RoundedRectangle (cornerRadius: 10, style: .continuous)
//                    .fill(.black.opacity (0.05))
//                    .frame (height: 75)
//            }
//        }
//        .padding(15)
//
//    }
    
    
    
}

struct designerProfile_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
