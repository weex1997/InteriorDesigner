//
//  home.swift
//  InteriorDesigner
//
//  Created by Asma Abdulkreem on 12/11/1444 AH.
//

import SwiftUI
import FirebaseAuth

var designerCheck = false

struct home: View {
    @State var userIDE = Auth.auth().currentUser?.uid
    @StateObject var viewModel = ViewModel()
    @State var showSheet = false
    @State var showChat = false
    @State var showProfile = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        
    }
    
    
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            NavigationView {
                
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(.systemPurple)]), startPoint: .top, endPoint: .center)
                        .ignoresSafeArea()
                    
                    Color(.init(white: 0.95, alpha: 1))
                        .offset(y: 400)
                    
                    ScrollView {
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search here...")
                            Spacer()
                            
                        }.font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.3)))
                            .cornerRadius(10)
                            .padding(16)
                        
                        DiscoverCategoriesView()
                        
                        VStack {
                            PopularDestinationsView()
                        }.background(Color(.init(white: 0.95, alpha: 1)))
                            .cornerRadius(16)
                            .padding(.top, 32)
                    }
                }
                
                .navigationTitle("Let's Find Your Designer.")
                
                .navigationBarItems(
                    leading:
                        Button {
                            showSheet = true
                            showChat = true
                        } label: {
                            if ((userIDE) != nil) {
                                NavigationLink(destination:allchat(),isActive: $showChat){}
                                Image(systemName: "message")
                                    .foregroundColor(.white)
                            }
                            else{
                                Image(systemName: "message")
                                    .foregroundColor(.white)
                                    .sheet(isPresented: $showSheet,onDismiss: {
                                        userIDE = Auth.auth().currentUser?.uid
                                        
                                    }){
                                        SignInButton()
                                            .presentationDetents([.height(200), .medium, .large])
                                            .presentationDragIndicator(.automatic)
                                    }
                            }
                            
                        })
                
                .navigationBarItems(
                    
                    trailing:
                        
                        Button {
                            showSheet = true
                            showProfile = true
                            print(self.viewModel.user.desinger)
                        } label: {
                            if ((userIDE) != nil) {
                                if(self.viewModel.user.desinger == true){
                                    NavigationLink(destination:designerProfile(size: size, safeArea: safeArea),isActive: $showProfile){}}
                                else{
                                    NavigationLink(destination:UserP2(),isActive: $showProfile){}}
                                Image(systemName: "person")
                                    .foregroundColor(.white)
                            }
                            else{
                                Image(systemName: "person")
                                    .foregroundColor(.white)
                                    .sheet(isPresented: $showSheet,onDismiss: {
                                        userIDE = Auth.auth().currentUser?.uid
                                        
                                    }){
                                        SignInButton()
                                            .presentationDetents([.height(200), .medium, .large])
                                            .presentationDragIndicator(.automatic)
                                    }
                            }
                            
                        })
            }.onAppear(){
                self.viewModel.getData(id: userIDE ?? "123")
            }
            
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(false)
            
        }
        
    }
}

struct Destination: Hashable {
    let name, country, imageName, rate: String
}

struct PopularDestinationsView: View {
    let destinations: [Destination] = [
        .init(name: "Nasser", country: "Modern, classic, new classic", imageName: "mo", rate:"5.00"),
        .init(name: "Nasser", country: "Modern, classic, new classic", imageName: "dr", rate:"5.00"),
        .init(name: "Nasser", country: "Modern, classic, new classic", imageName: "in" , rate:"5.00"),
    ]
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                VStack {
                    ForEach(viewModel.designers, id: \.id) { designer in
                        
                        NavigationLink(destination: profil()){
                            VStack(alignment: .leading, spacing: 0) {
                                
                                Image("mo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 327, height: 154)
                                    .cornerRadius(4)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 6)
                                
                                Text(designer.name!)
                                    .font(.system(size: 12, weight: .semibold))
                                
                                    .padding(.horizontal, 12)
                                    .padding(.bottom, 8)
                                
                                HStack{
                                    Text(designer.field!)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Image(systemName: "heart")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.primary)
                                    
                                }
                                .padding(.horizontal, 12)
                                .padding(.bottom, 8)
                                
                                
                                HStack{
                                    Text(designer.rate!+(".00"))
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.gray)
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.yellow)
                                }.padding(.horizontal, 12)
                                    .padding(.bottom, 8)
                            }
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
                        }
                    }
                    .padding()
                }
                .padding()
            }
        }.onAppear(){
            self.viewModel.fetchData()
        }
    }
}





struct Home: PreviewProvider {
    static var previews: some View {
        home()
    }
}

struct Category: Hashable {
    let name, imageName: String
}

struct DiscoverCategoriesView: View {
    
    let categories: [Category] = [
        .init(name: "All", imageName: ""),
        //        .init(name: "Home", imageName: ""),
        .init(name: "Favorite", imageName: ""),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 14) {
                ForEach(categories, id: \.self) { category in
                    VStack(spacing: 8) {
                        //                        Spacer()
                        Image(systemName: category.imageName)
                            .font(.system(size: 20))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5059075952, blue: 0.2313886285, alpha: 1)))
                            .background(Color.white)
                            .cornerRadius(64)
                        //                            .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
                        Text(category.name)
                            .font(.system(size: 12, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }.frame(width: 68)
                    
                }
            }.padding(.horizontal)
        }
    }
}
