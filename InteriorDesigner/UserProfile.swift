//
//  UserProfile.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI
import FirebaseAuth

struct UserProfile: View {
    @State var userIDE = Auth.auth().currentUser?.uid ?? ""
    @StateObject var viewModel = ViewModel()
//    @State var users : Users
//    init(){
//        let user = Users(id: (Auth.auth().currentUser?.uid.description) ?? "")
//        self._users = .init(initialValue: user)
//    }
    
    var body: some View {
        // Group{
        ZStack(alignment: .top){
            
//            NavigationLink(destination: home().navigationBarBackButtonHidden(false), isActive: $GotoHome){}
            
            Color("BC")
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack{
                    VStack{
                        
                        VStack{
                            ZStack{
                                
                                Circle()
                                    .foregroundColor(Color("line"))
                                Image ("b").resizable().aspectRatio(contentMode: .fill).clipShape (Circle ())
                                
                            }.frame(width: 110 , height: 110)
                                .padding(.leading)
                                .offset(x: -100 , y: 1)
                                .padding()
                            VStack{
                                TextField(self.viewModel.user.name ?? "name", text: $viewModel.user.name.defaultValue(""))
                                    .foregroundColor(Color("TextC"))
                                    .font(.body)
                                    .padding(11)
                                    .font(.body)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 9)
                                            .stroke(Color("line"), lineWidth: 2)
                                    )
                                    .padding(2)
                                
                                TextField(self.viewModel.user.phoneNumber ?? "phoneNumber", text: $viewModel.user.phoneNumber.defaultValue(""))
                                    .foregroundColor(Color("TextC"))
                                    .multilineTextAlignment(.leading)
                                    .font(.body)
                                    .padding(11)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 9)
                                            .stroke(Color("line"), lineWidth: 2)
                                    )
                                    .padding(2)
                            }
                            .padding(.top, -10.0)
                            
                            TextField(self.viewModel.user.styles ?? "Styles, Ex: Modern, classic, new classic", text: $viewModel.user.styles.defaultValue(""))
                                .foregroundColor(Color("TextC"))
                                .font(.body)
                                .padding(11)
                                .font(.body)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color("line"), lineWidth: 2)
                                )
                                .padding(2)
                            VStack{
                                Text("Field")
                                    .font(.body)
                                    .foregroundColor(Color("Primary"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.system(size: 17))
                                    .padding(.bottom, -30.0)
                                    .padding()
                                    .padding(.leading, -10.0)
                            }
                        }
                        VStack{
                            GridPicker()
                        }.padding()
                            .frame(width: 330, height: 60)
                        VStack{
                            TextField(self.viewModel.user.brief ?? "About, Here are space to write some information about you..",text: self.$viewModel.user.brief.defaultValue(""), axis: .vertical)
                                .foregroundColor(Color("TextC"))
                                .lineLimit(3, reservesSpace: true)
                                .padding()
                                .font(.body)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color("line"), lineWidth: 2)
                                )
                        }
                        VStack{
                            DesingerPhotoPicker()
                        }.padding(.vertical)
                        
                        
                    }.frame(width: 320, height: 630)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 0)
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    VStack{
                        
                        Button("Update") {
                            viewModel.updateData(id: self.viewModel.user.id)
                            //                        GotoHome = true
                        }
                        .bold()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Primary"))
                            .frame(width: 342, height: 48.58)
                        )
                        .padding()
                 
                        Button("Log Out") {
                            viewModel.signOut()
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                                exit(0)
                            }
                        }
                        .bold()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray)
                            .frame(width: 342, height: 48.58)
                        )
                        .padding()
                        
                        
                        Button("Delete Account") {
                            viewModel.deleteData()
                           
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                                exit(0)
                            }
                            
                        }
                        
                        .bold()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Re"))
                            .frame(width: 342, height: 48.58)
                        )
                        .padding()
                    }
                    .padding()
                    
                }
            }
            }
        
        
        
        .onAppear(){
            self.viewModel.getData(id: Auth.auth().currentUser?.uid ?? "1234")
        }
        
        //   }
        
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
