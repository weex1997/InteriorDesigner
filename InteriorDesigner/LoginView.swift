//
//  ContentView.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Brian Voong on 10/23/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct LoginView: View {
    
    let didCompleteLoginProcess: () -> ()
    
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    
//    @State private var shouldShowImagePicker = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        
                    if !isLoginMode {
                        Button {
//                            shouldShowImagePicker.toggle()
                        } label: {
//
                            VStack {
//                                if let image = self.image {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 128, height: 128)
//                                        .cornerRadius(64)
//                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundColor(Color(.label))
//                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 3)
                            )
//
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    }
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.red)
                }
                .padding()
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        }
        .navigationViewStyle(StackNavigationViewStyle())
//        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
//            ImagePicker(image: $image)
//                .ignoresSafeArea()
//        }
    }
    
    @State var image: UIImage?
    
    private func handleAction() {
        if isLoginMode {
//            print("Should log into Firebase with existing credentials")
            loginUser()
        } else {
            createNewAccount()
//            print("Register a new account inside of Firebase Auth and then store image in Storage somehow....")
        }
    }
    
    private func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            
            self.didCompleteLoginProcess()
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount() {

        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            
            self.storeUserInformation()
        }
    }
    
//    private func persistImageToStorage() {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
//        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
//        ref.putData(imageData, metadata: nil) { metadata, err in
//            if let err = err {
//                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
//                return
//            }
//            
//            ref.downloadURL { url, err in
//                if let err = err {
//                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
//                    return
//                }
//                
//                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
//                print(url?.absoluteString ?? "")
//                
//                guard let url = url else { return }
//                self.storeUserInformation(imageProfileUrl: url)
//            }
//        }
//    }
    
    private func storeUserInformation() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = [FirebaseConstants.email: self.email, FirebaseConstants.uid: uid]
        Firestore.firestore().collection(FirebaseConstants.users)
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    self.loginStatusMessage = "\(err)"
                    return
                }
                
                print("Success")
                
                self.didCompleteLoginProcess()
            }
    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        LoginView(didCompleteLoginProcess: {
            
        })
    }
}
