//
//  home.swift
//  InteriorDesigner
//
//  Created by Asma Abdulkreem on 12/11/1444 AH.
//

import SwiftUI

var designerCheck = false
struct home: View {
    
    @State var signinButton = SignInButton()
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
                        //                    HStack{
                        //                        Image(systemName: "message")
                        //                            .foregroundColor(.white)
                        //                    .font(.system(size: 30, weight: .semibold))
                        //                        Image(systemName: "person")
                        //                            .foregroundColor(.white)
                        //                            .font(.system(size: 30, weight: .semibold))
                        //
                        //                                        }
                        
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
                            if (signinButton.isSignIn) {
                                NavigationLink(destination:designerProfile(size: size, safeArea: safeArea),isActive: $showChat){}
                                Image(systemName: "person")
                                    .foregroundColor(.white)
                            }
                            else{
                                Image(systemName: "person")
                                    .foregroundColor(.white)
                                    .sheet(isPresented: $showSheet){
                                        signinButton
                                            .presentationDetents([.height(200), .medium, .large])
                                            .presentationDragIndicator(.automatic)
                                    }
                            }
                            
                        })
                
                .navigationBarItems(
                    
                    trailing:  Button {
                        showSheet = true
                        showProfile = true
                    } label: {
                        if (signinButton.isSignIn) {
                            NavigationLink(destination:allchat(),isActive: $showProfile){}
                            Image(systemName: "message")
                                .foregroundColor(.white)
                        }
                        else{
                            Image(systemName: "message")
                                .foregroundColor(.white)
                                .sheet(isPresented: $showSheet){
                                    signinButton
                                        .presentationDetents([.height(200), .medium, .large])
                                        .presentationDragIndicator(.automatic)
                                }
                        }
                        
                    })
            }
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
    
    var body: some View {
        VStack {
            //            HStack {
            //
            //                Spacer()
            //                Text("See all")
            //                    .font(.system(size: 12, weight: .semibold))
            //            }.padding(.horizontal)
            //            .padding(.top)
            //
            ScrollView(.horizontal) {
                VStack {
                    ForEach(destinations, id: \.self) { destination in
                        VStack(alignment: .leading, spacing: 0) {
                            
                            Image(destination.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 327, height: 154)
                                .cornerRadius(4)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 6)
                            
                            Text(destination.name)
                                .font(.system(size: 12, weight: .semibold))
                            
                                .padding(.horizontal, 12)
                                .padding(.bottom, 8)
                            
                            HStack{
                                Text(destination.country)
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
                                Text(destination.rate)
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
                    .padding()
                }
                .padding()
            }
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
