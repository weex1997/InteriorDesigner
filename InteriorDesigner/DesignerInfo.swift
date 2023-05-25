////
////  DesignerInfo.swift
////  InteriorDesigner
////
////  Created by AtheerAlshehri on 21/05/2023.
////
//
//import SwiftUI
//
//struct DesignerInfo: View {
//    var body: some View {
//        NavigationView{
//        //    ScrollView{
//                
//                VStack{
//                    
//                    VStack{
//                        Text("About Me")
//                            .font(.title)
//                            .foregroundColor(Color("Pr"))
//                            .bold()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        Text("an ambitious interior designer with 10 years of experience, interested in both classical and modern designs. I specialize in designing homes, cafes, and commercial spaces.")
//                        
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    VStack{
//                        Text("Intereste")
//                            .font(.title)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .foregroundColor(Color("Pr"))
//                            .bold()
//                        Text("classic, modern, new classic")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    
//                    VStack{
//                        Text("field")
//                            .font(.title)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .foregroundColor(Color("Pr"))
//                            .bold()
//                        HStack{
//                            ZStack{
//                                
//                                
//                                Capsule()
//                                    .fill(Color("Pr"))
//                                    .frame(width: 80, height: 28)
//                                Text("Home")
//                                
//                            } .frame(maxWidth: .infinity, alignment: .leading)
//                            
//                            ZStack{
//                                Capsule()
//                                    .fill(Color("Pr"))
//                                    .frame(width: 80, height: 28)
//                                Text("Coffee")
//                                
//                            } .padding(.leading,-300)
//                        }
//                        VStack{
//                            Text("Protofolio")
//                                .font(.title)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .foregroundColor(Color("Pr"))
//                                .bold()
//                           
//                            ScrollView(.horizontal) {
//                                        LazyHStack {
//                                Image("Im")
//                                    .resizable()
//                                    .frame(width: 100 ,height: 100)
//                                Image("Im1")
//                                    .resizable()
//                                    .frame(width: 100 ,height: 100)
//                                Image("Im2")
//                                    .resizable()
//                                    .frame(width: 100 ,height: 100)
//                              
//                                    Image("Im")
//                                        .resizable()
//                                        .frame(width: 100 ,height: 100)
//                                    Image("Im1")
//                                        .resizable()
//                                        .frame(width: 100 ,height: 100)
//                                    Image("Im2")
//                                        .resizable()
//                                        .frame(width: 100 ,height: 100)
//                                    
//                                }
//                            
//                            }
//                        }
//                        Button(action: { }) {
//                            Text("Log out")
//                                .bold()
//                                .foregroundColor(Color("Re"))
//                        }
//                        .background(RoundedRectangle(cornerRadius: 8)
//                                    
//                            .stroke(Color("Re"), lineWidth: 2)
//                                    
//                            .frame(width: 330, height: 48.58)
//                        )
//                        .padding(.top, 70)
//                        
//                        
//                    }
//                     .toolbar {
//                        ToolbarItem(placement: .principal) {
//                            Image("b")
//                                .resizable()
//                                .frame(width:100 ,height: 100)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            
//                        }
//                    }
//                    .navigationTitle("Profile Designer")
//                 
//                    .navigationBarItems(
//                        trailing: NavigationLink(destination:UserProfile()) {
//                            Image(systemName: "pencil.circle.fill")
//                        })
//                    .toolbarColorScheme(.dark, for: .navigationBar)
//                    .toolbarBackground( Color("Pr"), for: .navigationBar)
//                    .toolbarBackground(.visible, for: .navigationBar)
//                }
//            }
//        }
//    }
////}    Image("b")
////    .resizable()
////    .frame(width:100 ,height: 100)
//
//
//struct DesignerInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        DesignerInfo()
//    }
//}
