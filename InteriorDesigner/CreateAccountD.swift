//
//  CreateAccountD.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountD: View {
    
    @StateObject var viewModel = ViewModel()
    @State var users : Users
    init(){
        let user = Users(id: (Auth.auth().currentUser?.uid.description) ?? "")
        self._users = .init(initialValue: user)
    }
    
//    init() {
//
//        UINavigationBar.appearance().largeTitleTextAttributes=[.foregroundColor:UIColor.init(Color("Pr"))]
//        
//    }

    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                List {
                    
                    VStack{
                        
                        TextField("Name", text: $users.name.defaultValue(""))
                        //   .foregroundColor(Color("line"))
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
                        TextField("About", text: $users.brief.defaultValue(""))
                        //  .padding([.trailing, .bottom])
                            .padding()
                            .font(.body)
                            .padding( .bottom, 66.0)
                            .font(.body)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color("line"), lineWidth: 2)
                            )
                            .padding(2)
                        
                        
                    }
                    
                }
                
                HStack{
                    
                    NavigationLink(
                        destination: ContentView().navigationBarHidden(true),
                        label: {
                            Button("Next") {
                                viewModel.updateData(UsersUpdate: users)
                            }
                                .bold()
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Primary"))
                                    .frame(width: 330, height: 48.58)
                                )
                        })
                    
                    
                }
                
            }
            
            
            .navigationTitle("Create Account")
            .navigationBarTitleDisplayMode(.inline)
            
            
            .navigationBarItems(
                trailing: NavigationLink(destination:ContentView()) {
                    Text("Skip")
                        .foregroundColor(Color("Primary"))
                })
            
            
        }
    }
}


struct CreateAccountD_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountD()
    }
}
