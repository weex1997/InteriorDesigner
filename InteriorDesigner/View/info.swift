//
//  info.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 24/05/2023.
//

import SwiftUI

struct info: View {
    var body: some View {
        //Spacer()
        
        VStack{
            Spacer()
            VStack{
                Text("About Me")
                    .font(.title)
                    .foregroundColor(Color("Pr"))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
                
                Text("an ambitious interior designer with 10 years of experience, interested in both classical and modern designs. I specialize in designing homes, cafes, and commercial spaces.")
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
                Spacer()
            }
            VStack{
                Text("Intereste")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Pr"))
                    .bold()
                    .padding(5)
                Text("classic, modern, new classic")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
            }
            
            VStack{
                Text("field")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color("Pr"))
                    .bold()
                    .padding(5)
                HStack{
                    ZStack{
                        
                        
                        Capsule()
                            .fill(Color("Pr"))
                            .frame(width: 80, height: 28)
                        Text("Home")
                            
                    } .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                    
                    ZStack{
                        Capsule()
                            .fill(Color("Pr"))
                            .frame(width: 80, height: 28)
                        Text("Coffee")
                         
                    } .padding(.leading,-260)
                }
                VStack{
                    Text("Protofolio")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("Pr"))
                        .bold()
                        .padding(5)
                        .padding(.trailing,00)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            Image("Im")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            Image("Im1")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            Image("Im2")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            
                            Image("Im")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            Image("Im1")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                            Image("Im2")
                                .resizable()
                                .frame(width: 100 ,height: 100)
                                .padding(5)
                        }
                        Spacer()
                            .padding(.bottom)
                            
                           
                    }
                }
            }
                Button(action: { }) {
                    Text("Upload")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 150,height: 50)
                }
                .background(RoundedRectangle(cornerRadius: 8)
                            
                    .fill(Color("Pr"))
                    .frame(width: 330, height: 48.58))
                
              Spacer()
         //   VStack{
                Text(" * JPEG, PNG,  Pdf ( Max size : 5M )")
                    .padding(.bottom,20)
                    .padding(.trailing,60)
          //  }
            Button(action: { }) {
                Text("Log out")
                    .bold()
                    .foregroundColor(Color("Re"))
            }
            .background(RoundedRectangle(cornerRadius: 8)
                        
                .stroke(Color("Re"), lineWidth: 2)
                        
                .frame(width: 330, height: 48.58)
            )
            Spacer()
            
        } .padding(20)
    }
}
    struct info_Previews: PreviewProvider {
        static var previews: some View {
            info()
        }
    }
