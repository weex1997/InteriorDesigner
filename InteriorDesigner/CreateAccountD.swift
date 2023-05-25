//
//  CreateAccountD.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI

struct CreateAccountD: View {
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var about: String = ""
    @State var Designer = false
    
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
                        TextField("About", text: $about)
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
                            
                            Text("Next")
                                .bold()
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Color("Pr"))
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
                        .foregroundColor(Color("Pr"))
                })
            
            
        }
    }
}


struct CreateAccountD_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountD()
    }
}
