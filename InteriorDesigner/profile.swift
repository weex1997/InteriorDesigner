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
    @State var users : Users
    init(){
        let user = Users(id: (Auth.auth().currentUser?.uid.description) ?? "")
        self._users = .init(initialValue: user)
    }

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
                            
                            
                            TextField("Name", text: $users.name.defaultValue(""))
                                .font(.body)
                                .padding(11)
                                .font(.body)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color("line"), lineWidth: 2)
                                )
                                .padding(2)
                            
                            TextField("Phone Number", text: $users.phoneNumber.defaultValue(""))
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
            
            Button("Delet Account") {
                viewModel.deleteData(UsersDelete: users)
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
            
        }
        
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
