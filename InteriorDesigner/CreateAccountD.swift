//
//  CreateAccountD.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountD: View {
    @State var userIDE = Auth.auth().currentUser?.uid ?? ""

    @StateObject var viewModel = ViewModel()
//    @State var user : User
//    init(){
//        let user = User(id: (Auth.auth().currentUser?.uid.description) ?? "")
//        self._user = .init(initialValue: user)
//    }
    
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
                        
                        TextField("Name", text: $viewModel.user.name.defaultValue(""))
                        //   .foregroundColor(Color("line"))
                            .font(.body)
                            .padding(11)
                            .font(.body)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color("line"), lineWidth: 2)
                            )
                            .padding(2)
                        
                        TextField("Phone Number", text: $viewModel.user.phoneNumber.defaultValue(""))
                            .font(.body)
                            .padding(11)
                            .font(.body)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color("line"), lineWidth: 2)
                            )
                            .padding(2)
                        TextField("About", text: $viewModel.user.brief.defaultValue(""))
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
                                viewModel.updateData(id: userIDE)}
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
