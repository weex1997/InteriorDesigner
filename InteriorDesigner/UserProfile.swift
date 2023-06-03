//
//  UserProfile.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI
import FirebaseAuth

struct UserProfile: View {
    
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
                            
                            TextField("Feild", text: $users.field.defaultValue(""))
                                .font(.body)
                                .padding(11)
                                .font(.body)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color("line"), lineWidth: 2)
                                )
                                .padding(2)
                            
                            TextField("Interests", text: $users.experiance.defaultValue(""))
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
        destination: ContentView().navigationBarHidden(true), label: {
            Button("Update") {
                viewModel.updateData(UsersUpdate: users)
            }
                            .padding()
                               
                            })
                        .navigationBarHidden(true)
                      
                            .bold()
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Primary"))
                            .frame(width: 330, height: 48.58)
                                )
                            .padding(.top, 470)
                        }
                        
                  
                   
                }
                
         //   }
            
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.red)
            
        }
        
    }
}
struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
