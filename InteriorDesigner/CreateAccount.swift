//
//  CreateAccount.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 21/05/2023.
//

import SwiftUI
import FirebaseAuth

struct CreateAccount: View {
    @State var userIDE = Auth.auth().currentUser?.uid
    @StateObject var viewModel = ViewModel()
    @State var Next = false
    @State var Done = false
    @FocusState var isInputActive: Bool
    @State var isDesigner = false
    
    var body: some View {
        NavigationView {
         
            ZStack(alignment: .top){
                Color("BC")
                               .ignoresSafeArea()
                  
                    NavigationLink(destination: CreateAccountD().navigationBarBackButtonHidden(false), isActive: $Next){}
                    NavigationLink(destination: home().navigationBarBackButtonHidden(false), isActive: $Done){}
                VStack{
                    VStack{
                        Spacer()
                        VStack(){
                            Text("Name")
                                .foregroundColor(Color("Primary"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 17))
                                .padding(.vertical, 5.0)
                        }
                        TextField("Name", text: $viewModel.user.name.defaultValue("Name"))
                            .foregroundColor(Color("TextC"))
                            .multilineTextAlignment(.leading)
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
                        VStack(){
                            Text("Phone Number")
                                .foregroundColor(Color("Primary"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 17))
                                .padding(.vertical, 5.0)
                        }
                        TextField("Phone Number", text: $viewModel.user.phoneNumber.defaultValue("Phone Number"))
                            .foregroundColor(Color("TextC"))
                            .multilineTextAlignment(.leading)
                            .font(.body)
                            .padding(11)
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
                        VStack(){
                            Text("Gender")
                                .foregroundColor(Color("Primary"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(size: 17))
                                .padding(.vertical, 5.0)
                        }
                        
                        VStack(){
                            HStack{
                                Text("Select your gender")
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .foregroundColor(Color("line"))
                                
                                Spacer()
                                
                                Picker("Gender", selection: $viewModel.user.gender.defaultValue("")) {
                                    Text("Male").tag("1")
                                    Text("Female").tag("2")
                                }.accentColor(Color("Primary"))
                                    .font(.system(size: 16))
                            }   .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color("line"), lineWidth: 2))      .frame(width: 318,height: 45)
                            
                        }
                        
                        Toggle(isOn: $isDesigner) {
                            
                            Text("Are you Designer ?")
                                .foregroundColor(Color("Primary"))
                            
                        }
                        .onChange(of: isDesigner, perform: { value in
                            //Once the toggle is interacted with, set showText to true
                            self.viewModel.user.desinger = isDesigner
                            
                            
                        })
                        .tint(Color("Primary"))
                        .padding()
                        
                        
                        
                        Spacer()
                        
                        
                    }.frame(width: 320, height: 350)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)                    .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 0)
                    VStack{
                        Button() {
                            viewModel.updateData()
                            if(isDesigner){
                                Next = true
                            }else{
                                Done = true
                            }
                        }label: {
                            Text( isDesigner ? "Next" : "Done" )
                        }
                        .bold()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Primary"))
                            .frame(width: 330, height: 48.58)
                        )
                    }.padding(.top,30)
                }
            }
                
            .navigationBarBackButtonHidden(false)
        }.onAppear(){
            self.viewModel.getData()
        }
        .accentColor(Color("Primary"))
    }
}

 
struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
