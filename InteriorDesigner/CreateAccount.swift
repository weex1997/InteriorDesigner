//
//  CreateAccount.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI
import FirebaseAuth

struct CreateAccount: View {
    
    @StateObject var viewModel = ViewModel()
    @State var users : Users
    init(){
        let user = Users(id: (Auth.auth().currentUser?.uid.description) ?? "")
        self._users = .init(initialValue: user)
    }
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
                            
                            Toggle(isOn: $users.desinger.defaultValue(false)) {
                                
                                    Text("Are you Designer ?")
                                    .foregroundColor(Color("Primary"))
                                
                            }
                            .tint(Color("Primary"))
                            .padding()
                            
                           
                        }
                        
                    }
                    
                    Button("Next") {
                        viewModel.updateData(UsersUpdate: users)}
                    .bold()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Primary"))
                            .frame(width: 330, height: 48.58)
                                )
                            .padding(.top, 70)
                        
                        
                  
                }
                
            
            .navigationTitle("Create Account")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.red)
            
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
