//
//  CreateAccount.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI

struct CreateAccount: View {
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State var Designer = false
    var body: some View {
        NavigationView {
         
                ZStack{
                    
                    List {
                        
                        VStack{
                            
                            TextField("Name", text: $name)
                             //   .foregroundColor(Color("line"))
                                .font(.body)
                                .padding(11)
                                .font(.body)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color("line"), lineWidth: 2)
                                )
                                .padding(2)
                            
                            TextField("Phone Number", text: $phone)
                                .font(.body)
                                .padding(11)
                                .font(.body)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color("line"), lineWidth: 2)
                                )
                                .padding(2)
                            
                            Toggle(isOn: $Designer) {
                                
                                    Text("Are you Designer ?")
                                    .foregroundColor(Color("Pr"))
                                
                            }
                            .tint(Color("Pr"))
                            .padding()
                            
                           
                        }
                        
                    }
                    
                    NavigationLink(
                        destination: ContentView().navigationBarHidden(true),
                        label: {
                            
                            Text("Next")
                                .bold()
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Pr"))
                                    .frame(width: 330, height: 48.58)
                                )
                        })
                        
                        
                  
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
