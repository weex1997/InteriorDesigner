//
//  UserP2.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 06/06/2023.
//

import SwiftUI

struct UserP2: View {
    @State var Designer = false
    
    var body: some View {
        NavigationView {
        
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
                            
                            HStack{
                                VStack{
                                    Text("Name Customer")
                                        .font(.title2)
                                        .foregroundColor(Color("Primary"))
                                        .padding(.leading,80)
                                    
                                    Text("Customer")
                                    .foregroundColor(Color("line"))                                            }
                            }
                            
                            
                        }
                        VStack{
                            HStack{
                                Image(systemName: "phone")
                                Text("+966 51 234567")
                                
                            } .foregroundColor(Color("Primary"))
                                .padding(.top)
                                .padding(.trailing,140)
                        }
                        VStack{
                            HStack{
                                
                                
                                
                                Toggle(isOn: $Designer) {
                                    
                                    Text("Switch to designer account?")
                                        .foregroundColor(Color("Primary"))
                                    
                                }
                                .tint(Color("Primary"))
                                .padding()
                                
                            } .foregroundColor(Color("Primary"))
                                .padding(.top,1)
                            
                            //.padding(.trailing,100)
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                HStack{
                    
                    NavigationLink(
                        destination: ContentView().navigationBarHidden(true), label: {
                            Text("Log out")
                            
                                .padding()
                            
                        })
                    .navigationBarHidden(true)
                    
                    .bold()
                    .foregroundColor(Color("Re"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(Color("Re"), lineWidth: 2)
                            .frame(width: 330, height: 48.58)
                    )
                    
                }
                
                
                
                
            }
            
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(Color("Pr"))
            
        }
    }
}


struct UserP2_Previews: PreviewProvider {
    static var previews: some View {
        UserP2()
    }
}
