//
//  profile.swift
//  InteriorDesigner
//
//  Created by Asma Abdulkreem on 12/11/1444 AH.
//

import SwiftUI
import FirebaseAuth

struct profil: View {
    // struct LoginView: View {
    
    @State var isLoginMode = false
    
    @StateObject var viewModel = ViewModel()
    let name = UserDefaults.standard.string(forKey: "name") ?? nil
    let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? nil


    var body: some View {
        NavigationView {
           // Group{
                ZStack{
                    
                    List {
                        
                        VStack{
                            ZStack{
                                Image("Circle")
                                    .resizable()
                                    .frame(width: 120 , height: 120)
                                    .padding(.trailing,200)
                                
                                photopicer()
                                    .padding()
                                    .padding(.top ,70)
                                    .padding(.trailing,130)
                                GeometryReader {
                                    let rect = $0.frame (in: .global)
                                    Image ("b")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame (width: rect.width, height: rect.height)
                                        .clipShape (Circle ())
                                }
                                .padding(.trailing,200)
                             

                                
                            }
//                            HStack{
//                                Button(action: { }) {
//
//                                    Image(systemName: ("pencil"))
//                                        .frame(width: 25 , height: 25)
//
//                                }
//                            }
//                            Text("Name")
                            
                            TextField(name ?? "name", text: $viewModel.user.name.defaultValue(""))
                                .font(.body)
                                .padding(11)
                                .font(.body)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color("line"), lineWidth: 2)
                                )
                                .padding(2)
                            
                            TextField(phoneNumber ?? "phoneNumber", text: $viewModel.user.phoneNumber.defaultValue(""))
                                .font(.body)
                                .padding(11)
                                .font(.body)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color("line"), lineWidth: 2)
                                )
                                .padding(2)
                            Spacer()
                            
                           
                        }
                        
                    }
                    
                    HStack{
                        
            NavigationLink(
        destination: ContentView().navigationBarHidden(true), label: {
            
            Button("Log Out") {
                viewModel.signOut()
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                  UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    exit(0)

                              }
                
            }
                            .padding()
                               
                            })
                        .navigationBarHidden(true)
                      
                            .bold()
                            .foregroundColor(Color("Re"))
                           
                            .padding(.top)
                        }
                        
                  
                   
                }
                
         //   }
            
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.red)
            
        }.onAppear()
        
    }
}

//            ScrollView {
//
//                VStack(spacing: 16) {
//                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
//                        //
//                    }.pickerStyle(SegmentedPickerStyle())
//
//                    if !isLoginMode {
//                        ZStack{
//                        Button {
//
//                        } label: {
//                            Image("Circle")
//                                .resizable()
//                                .frame(width: 120 , height: 120)
//                                .padding(.trailing,200)
//                        }
//                            photopicer()
//                                .padding()
//                                .padding(.top ,70)
//                                .padding(.trailing,130)
//                            GeometryReader {
//                                let rect = $0.frame (in: .global)
//                                Image("man")
////                                Image(systemName: "checkmark")
////                                    .resizable()
////                                    .frame(width: 20, height: 20)
////
////                                    .font(.system(size: 64))
////                                    .padding()
//                            }
//
//                        }
//
//                    }
//                }
//
//
//                Group {
//                    TextField("email", text: $email)
//                        .font(.body)
//                        .padding(11)
//                        .font(.body)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 9)
//                                .stroke(Color("line"), lineWidth: 2)
//                        )
//                        .padding(2)
//
//                    TextField("Number", text: $Number)
//                        .font(.body)
//                        .padding(11)
//                        .font(.body)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 9)
//                                .stroke(Color("line"), lineWidth: 2)
//                        )
//                        .padding(2)
//                    Button {
//                        //   handleAction()
//                    } label: {
//                        HStack {
//                            Spacer()
//                            Text( "Update")
//                                .bold()
//                                .foregroundColor(.white)
//                                .background(RoundedRectangle(cornerRadius: 8)
//                                .fill(Color("Primary"))
//                                .frame(width: 330, height: 48.58)
//                                    )
//                            Spacer()
//                        }
//
//                    }
//                }
//                .padding(12)
//                .background(Color.white)
//
////
//                Button {
////                       handleAction()
//                }
//            label: {
//                HStack {
//                    Spacer()
//                    Text( "Delete Account")
//                        .foregroundColor(.red)
//                                                    .padding(.vertical, 100)
//                                                    .font(.system(size: 20, weight: .semibold))
//
//                    Spacer()
//                }
//            }
//            .padding()
//
//            }
//            .navigationTitle("My Profile")
//            .navigationBarTitleDisplayMode(.inline)
//
//            .foregroundColor(.purple)
//            .background(Color(.init(.white))
//
//                .ignoresSafeArea())        }
//    }
//}
//        private func handleAction() {
//            if isLoginMode {
//                print("Should log into Firebase with existing credentials")
//            } else {
//                print("Register a new account inside of Firebase Auth and then store image in Storage somehow....")
//            }
//        }


struct profil_Previews: PreviewProvider {
    static var previews: some View {
        profil()
    }
}
