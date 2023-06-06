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

    @State var isDesigner = false

    var body: some View {
        NavigationView {
         
            ZStack(alignment: .top){
                Color("BC")
                               .ignoresSafeArea()
                  
                    NavigationLink(destination: CreateAccountD().navigationBarBackButtonHidden(false), isActive: $Next){}
                    NavigationLink(destination: home().navigationBarBackButtonHidden(false), isActive: $Done){}
                VStack{
                    Spacer()
                    TextField("Name", text: $viewModel.user.name.defaultValue(""))
                       .foregroundColor(Color("Primary"))
                        .multilineTextAlignment(.leading)
                        .padding(11)
                        .font(.body)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color("line"), lineWidth: 2)
                        )
                        .padding(2)
                    
                    TextField("Phone Number", text: $viewModel.user.phoneNumber.defaultValue(""))
                        .foregroundColor(Color("Primary"))
                         .multilineTextAlignment(.leading)
                        .font(.body)
                        .padding(11)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color("line"), lineWidth: 2)
                        )
                        .padding(2)
                 
                        VStack(){
                            HStack{
                                Text("Gender")
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .foregroundColor(Color("Primary"))
                                
                                Spacer()
                                
                                Picker("Gender", selection: $viewModel.user.gender.defaultValue("")) {
                                    Text("Male").tag("0")
                                    Text("Female").tag("1")
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

                    VStack{
                        Button() {
                            viewModel.updateData(id: viewModel.user.id)
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
                            .frame(width: 320, height: 48.58)
                        )
                    }.padding()
                }.frame(width: 320, height: 320)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                  
            }
                
            
            .navigationTitle("Create Account")
            .navigationBarTitleDisplayMode(.inline)
            .foregroundColor(.red)
            .navigationBarBackButtonHidden(false)
        }.onAppear(){
            self.viewModel.getData(id: userIDE ?? "123")
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount()
    }
}
