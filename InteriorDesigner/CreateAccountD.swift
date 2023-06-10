//
//  CreateAccountD.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI
import FirebaseAuth

struct CreateAccountD: View {
    
    @StateObject var viewModel = ViewModel()
    @State var userIDE = Auth.auth().currentUser?.uid
    @State var GoHome = false
    @State var gridPicher = GridPicker()
    @FocusState var isInputActive: Bool

   
    
    //    init() {
    //
    //        UINavigationBar.appearance().largeTitleTextAttributes=[.foregroundColor:UIColor.init(Color("Pr"))]
    //
    //    }
    
    var body: some View {
        
        
        
        ZStack(alignment: .top){
            Color("BC")
                .ignoresSafeArea()
            
            NavigationLink(destination: home().navigationBarBackButtonHidden(false), isActive: $GoHome){}
            VStack{
            VStack {
                VStack(){
                    Text("Styles")
                        .foregroundColor(Color("Primary"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17))
                        .padding(.vertical, 5.0)
                }
                VStack{
                    
                    TextField("Styles, Ex: Modern, classic, new classic", text: $viewModel.user.styles.defaultValue("Styles, Ex: Modern, classic, new classic"))
                        .foregroundColor(Color("TextC"))
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .padding(11)
                        .font(.body)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color("line"), lineWidth: 2)
                        )
                        .padding(2)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()

                                Button("Done") {
                                    isInputActive = false
                                }
                            }
                        }
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
                
                VStack(){
                    Text("About")
                        .foregroundColor(Color("Primary"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17))
                        .padding(.vertical, 5.0)
                }
                
                VStack{
                    TextField("About, Here are space to write some information about you..",text: self.$viewModel.user.brief.defaultValue("About, Here are space to write some information about you.."), axis: .vertical)
                        .foregroundColor(Color("TextC"))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3, reservesSpace: true)
                        .padding()
                        .font(.body)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color("line"), lineWidth: 2)
                        )
                        .focused($isInputActive)
                                        .toolbar {
                                            ToolbarItemGroup(placement: .keyboard) {
                                                Spacer()

                                                Button("Done") {
                                                    isInputActive = false
                                                }
                                            }
                                        }
                }
                VStack(){
                    Text("Portfolio")
                        .foregroundColor(Color("Primary"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 17))
                        .padding(.vertical, 5.0)
                }
                VStack{
                    DesingerPhotoPicker()
                }.padding(.vertical)
                
                
                
            }.frame(width: 320, height: 530)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 0)
            
            VStack{
                
                
                Button("Done") {
                    viewModel.getData()
                    viewModel.updateData()
                    GoHome = true                            }
                .bold()
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 8)
                    .fill(Color("Primary"))
                    .frame(width: 330, height: 48.58)
                )
                
                
                
            }.padding()
                .padding(.top, 20)
        }
            
        }
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.inline)
        
        .navigationBarItems(
            trailing: NavigationLink(destination:home().navigationBarBackButtonHidden(false)) {
                Text("Skip")
                    .foregroundColor(Color("Primary"))
            })
        .onAppear(){
            self.viewModel.getData()
        }
        
    }
    
    
    
}


struct CreateAccountD_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountD()
    }
}
