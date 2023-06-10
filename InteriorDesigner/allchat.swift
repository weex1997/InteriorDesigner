////
////  allchat.swift
////  InteriorDesigner
////
////
////  Created by Asma Abdulkreem on 12/11/1444 AH.
////
//import SwiftUI
//
//struct allchat: View {
//  
//        @State var shouldShowLogOutOptions = false
//        
//        private var customNavBar: some View {
//            HStack(spacing: 16) {
//                
//                
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("Chat")
////                        .foregroundColor(.purple)
//                        .frame(width: 500, height: 50)
//                        .font(.system(size: 24, weight: .bold))
//                     
////                 
//                    
//                }
//                
//                Spacer()
//                Button {
//                    shouldShowLogOutOptions.toggle()
//                    
//                } label: {
//                 
//                }
//            }
//            .padding()
//        }
//        
//        var body: some View {
//            NavigationView {
//                
//                
//                VStack {
//                    //                    customNavBar
//                    Text("Chats")
//                        .bold()
//                    VStack {
//                        NavigationLink(destination:ChatGPT3View().navigationBarHidden(true)){
//                            HStack(spacing: 30) {
//                                Image("assistant")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .font(.system(size: 5))
//                                
//                                    .padding(8)
//                                // .overlay(RoundedRectangle(cornerRadius: 44)
//                                //  .stroke(Color(.label), //lineWidth: 1)
//                                //    )
//                                
//                                
//                                VStack(alignment: .leading) {
//                                    Text("ChatGPT")
//                                        .font(.system(size: 16, weight: .bold))
//                                    Text("-")
//                                        .font(.system(size: 14))
//                                        .foregroundColor(Color(.lightGray))
//                                }
//                                Spacer()
//                                VStack{
//                                    Text("Beta")
//                                        .frame(width: 60,height: 30)
//                                        .background(Color("Primary"))
//                                        .foregroundColor(.white)
//                                        .cornerRadius(5)
////                                        .padding(.bottom)
//                                    Image(systemName: "pin.fill")
//                                        .font(.system(size: 14, weight: .semibold))
//                                        .foregroundColor(Color("Primary"))
//                                    //  .resizable()
//                                        .scaledToFill()
//                                    
//                                        .clipped()
//                                        .cornerRadius(5)
//                                    
//                                }
//                            }
//                        }
//                        Divider()
//                            .padding(.vertical, 1)
//                    }.padding(.horizontal)
//                    messagesView
//                }
//                .overlay(
//                    newMessageButton, alignment: .bottom)
//                .navigationBarHidden(true)
//                
//            }
//        }
//        
//        private var messagesView: some View {
//            ScrollView {
//                ForEach(0..<4, id: \.self) { num in
//                    VStack {
//                        HStack(spacing: 30) {
//                            Image("man")
//                                .font(.system(size: 5))
//                            
//                                .padding(8)
//                               // .overlay(RoundedRectangle(cornerRadius: 44)
//                                          //  .stroke(Color(.label), //lineWidth: 1)
//                            //    )
//                            
//                            
//                            VStack(alignment: .leading) {
//                                Text("Username")
//                                    .font(.system(size: 16, weight: .bold))
//                                Text("Message sent to user")
//                                    .font(.system(size: 14))
//                                    .foregroundColor(Color(.lightGray))
//                            }
//                            Spacer()
//                            
//                            Text("22d")
//                                .font(.system(size: 14, weight: .semibold))
//                              //  .resizable()
//                                .scaledToFill()
//                              
//                                .clipped()
//                                .cornerRadius(5)
//                            
//                        }
//                        Divider()
//                            .padding(.vertical, 1)
//                    }.padding(.horizontal)
//                    
//                }.padding(.bottom, 5)
//            }
//        }
//        
//        private var newMessageButton: some View {
//            Button {
//                
//            } label: {
//
//            }
//        }
//    }
//
//
//struct Allchat: PreviewProvider {
//    static var previews: some View {
//        allchat()
//    }
//}
