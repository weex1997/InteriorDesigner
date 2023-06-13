//
//  Home.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 23/05/2023.
//

import SwiftUI
import WaterfallGrid
import FirebaseAuth

struct OtherDesinerPage: View {
    @State var users : Users
    
    @State var goToEdit = false
    @StateObject var viewModel = ViewModel()
//    init(){
//           let user = Users(id: (Auth.auth().currentUser?.uid.description) ?? "")
//           self._users = .init(initialValue: user)
//
//       }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack{
//                NavigationLink(destination: UserProfile().navigationBarBackButtonHidden(false), isActive: $goToEdit){}
                
                VStack() {
                    
                    VStack{
                        ZStack {
                            
                            Rectangle()
                            
                                .fill (Color("Primary").gradient)
                                

                            
                            
                            VStack(spacing: 10) {
                                
                                ZStack{
                                    if (self.users.gender == "1") {
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
                                        Text (self.users.name)
                                            .font (.title)
                                            .fontWeight (.bold)
                                            .foregroundColor (.white)
                                    }
                                    VStack{
                                        Text(self.users.styles )
                                            .foregroundColor (.white)
                                    }
                                    VStack{
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                            Text("\(self.users.rate ?? "5" ).00")
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                
                            }
                        }

                    }
                    .frame (height: 420)
                    

                    VStack{
                        VStack{
                            VStack{
                                Text("About Me")
                                    .font(.title)
                                    .foregroundColor(Color("Primary"))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .multilineTextAlignment(.leading)
                                
                                Text(self.users.brief )
                                    .foregroundColor(Color("TextC"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .multilineTextAlignment(.leading)
                                
                            }
                            VStack{
                                Text("Styles")
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color("Primary"))
                                    .bold()
                                    .padding(5)
                                Text(self.users.styles)
                                    .foregroundColor(Color("TextC"))
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
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding(5)
                            
                            HStack {
                                ForEach(self.users.field, id: \.self) { item in
                                    HStack{
                                        Text(item)
                                            .foregroundColor(Color.white)
                                    }.frame(width: 90, height: 28)
                                        .background(Color("Primary"))
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    
                                    
                                    
                                    //                        Text(self.viewModel.user.field ?? [""])
                                    
                                }
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding(5)
                            
                            VStack{
                                Text("Protofolio")
                                    .font(.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color("Primary"))
                                    .bold()
                                    .padding(5)
                                    .padding(.trailing,00)
                            }
                            VStack{
                       
                                   
                                WaterfallGrid(self.users.images, id: \.self) { item in
                                            AsyncImage(url: URL(string: "\(item)"))
                                            { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                
                                                    

                                                   
                                                    .cornerRadius(10)
                                                
                                            } placeholder: {
                                                Color.gray
                                                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                                            }
                                        }
                                        .gridStyle(
                                            columnsInPortrait: 2,
                                            columnsInLandscape: 3,
                                            spacing: 8,
                                            animation: .easeInOut(duration: 0.5)
                                        )
                                        .scrollOptions(direction: .vertical)
                                        .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                                        
                         
                                    
                            }
                        
                            
                        } .padding(20)
                            
                        
                    }
                    }
                }
                .background {
                    ScrollDetector { offset in
                        print(offset)
                        
                    } onDraggingEnd: { offset, velocity in
                        
                    }
                }
            }                .edgesIgnoringSafeArea(.top)

        }
//            .onAppear(){
//                self.viewModel.getData()
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
