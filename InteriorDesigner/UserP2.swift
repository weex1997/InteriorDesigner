//
//  UserP2.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 06/06/2023.
//

import SwiftUI
import FirebaseAuth

struct UserP2: View {
    @State var goToEdit = false
    @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        
        ZStack(alignment: .top){
            
            NavigationLink(destination: profil().navigationBarBackButtonHidden(false), isActive: $goToEdit){}
            
            Color("BC")
                .ignoresSafeArea()
            VStack{
                
                VStack{
                    VStack(alignment: .trailing){
                        Button {
                            goToEdit = true
                            
                        } label: {
                            Image(systemName: "pencil")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("line"))
                        }
                    }.offset(x: 135 , y: 10)
                    HStack{
                        ZStack{
                            
                            Circle()
                                .foregroundColor(Color("line"))

                            Image ("b").resizable().aspectRatio(contentMode: .fill).clipShape (Circle ())
                            
                            //                            .padding(.trailing,-200)
                            
                        }.frame(width: 110 , height: 110)
                            .padding(.leading)
                        
                        
                        
                        //                            Image("Circle")
                        //                                .resizable()
                        //                                .frame(width: 120 , height: 120)
                        //                                .padding(.trailing,200)
                        //
                        //                            photopicer()
                        //                                .padding()
                        //                                .padding(.top ,70)
                        //                                .padding(.trailing,130)
                        //                            GeometryReader {
                        //                                let rect = $0.frame (in: .global)
                        //                                Image ("b")
                        //                                    .resizable()
                        //                                    .aspectRatio(contentMode: .fill)
                        //                                    .frame (width: rect.width, height: rect.height)
                        //                                    .clipShape (Circle ())
                        //                            }
                        //                            .padding(.trailing,200)
                        
                        VStack(alignment: .leading, spacing: 6){
                            Text(self.viewModel.user.name ?? "Name")
                                .font(.title2)
                                .foregroundColor(Color("Primary"))
                                
                            //                                .padding(.leading,80)
                            
                            Text("Customer")
                                .foregroundColor(Color("line"))
                            
                        }.padding(.leading, -20.0)
                            .frame(width: 150)
                            .padding(.top, 20.0)
                    }.offset(x: -20 , y: -40)
                        .padding(.top, 25.0)
                        .frame(width: 340 , height: 110)
                            .padding(.leading)
                    
                    
                    
                    
                    VStack{
                        HStack{
                            Image(systemName: "phone")
                            Text("+966 \(self.viewModel.user.phoneNumber ?? "5xxxxxxxx")")
                            
                        } .foregroundColor(Color("Primary"))
                            .padding(.trailing,140)
                    }.padding(.top, -10.0)
                        .padding(.bottom)
                    
                    VStack{
                        //                            HStack{
                        //
                        //
                        //
                        //                                Toggle(isOn: $Designer) {
                        //
                        //                                    Text("Switch to designer account?")
                        //                                        .foregroundColor(Color("Primary"))
                        //
                        //                                }
                        //                                .tint(Color("Primary"))
                        //                                .padding()
                        //
                        //                            } .foregroundColor(Color("Primary"))
                        //                                .padding(.top,1)
                        
                        //.padding(.trailing,100)
                    }
                    
                    
                    
                    
                }.frame(width: 320, height: 200)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 0)
                
                VStack{
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
            }//vstack
        }.onAppear(){
            self.viewModel.getData()
        }
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}


struct UserP2_Previews: PreviewProvider {
    static var previews: some View {
        UserP2()
    }
}
