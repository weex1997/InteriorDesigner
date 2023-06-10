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
    
    @State var GotoHome = false
    @State var userIDE = Auth.auth().currentUser?.uid
    @StateObject var viewModel = ViewModel()
    @State var isDesigner = false
    @FocusState var isInputActive: Bool

    var body: some View {
        // Group{
        ZStack(alignment: .top){
            
            NavigationLink(destination: home().navigationBarBackButtonHidden(false), isActive: $GotoHome){}
            
            Color("BC")
                .ignoresSafeArea()
            VStack{
                
                VStack{
                    ZStack{
                        
                        Circle()
                            .foregroundColor(Color("line"))
                        Image ("b").resizable().aspectRatio(contentMode: .fill).clipShape (Circle ())
                        
                    }.frame(width: 110 , height: 110)
                        .padding(.leading)
                        .offset(x: -100 , y: -60)
                        .padding(.top,100)
                    VStack{
                        VStack(){
                            Text("Name")
                                .foregroundColor(Color("Primary"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 17))
                                .padding(.vertical, 5.0)
                        }
                        TextField(self.viewModel.user.name ?? "name", text: $viewModel.user.name.defaultValue("name"))
                            .foregroundColor(Color("TextC"))
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .padding(11)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color("line"), lineWidth: 2)
                            )
                            .padding(2)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()

                                    Button("Done") {
                                        isInputActive = false
                                    }
                                }
                            }
                        VStack(){
                            Text("Phone Number")
                                .foregroundColor(Color("Primary"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 17))
                                .padding(.vertical, 5.0)
                        }
                        TextField(self.viewModel.user.phoneNumber ?? "phoneNumber", text: $viewModel.user.phoneNumber.defaultValue("phoneNumber"))
                            .foregroundColor(Color("TextC"))
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .padding(11)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color("line"), lineWidth: 2)
                            )
                            .padding(2)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()

                                    Button("Done") {
                                        isInputActive = false
                                    }
                                }
                            }
                    }.padding()
                        .padding(.top, -50.0)
                    
                    VStack{
          
                        Toggle(isOn: $isDesigner) {
                            
                            Text("Switch to designer account?")
                                .foregroundColor(Color("Primary"))
                                .frame(width: 220)

                        }
                        .onChange(of: isDesigner, perform: { value in
                            //Once the toggle is interacted with, set showText to true
                            self.viewModel.user.desinger = isDesigner
                            
                            
                        })
                        .tint(Color("Primary"))
                    }
                    .padding([.leading, .bottom, .trailing])

                    
                }.frame(width: 320, height: 430)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 0)
                
                
                
                
                VStack{
                    
                    Button("Update") {
                        viewModel.updateData()
                        GotoHome = true
                    }
                    .bold()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color("Primary"))
                        .frame(width: 342, height: 48.58)
                    )
                    .padding()
                    
                }
                .padding(.top,20)
            }
        }
        
        
        
        .onAppear(){
            self.viewModel.getData()
        }
        
        //   }
        
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
        
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
