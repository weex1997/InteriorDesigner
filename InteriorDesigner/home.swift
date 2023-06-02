//
//  home.swift
//  InteriorDesigner
//
//  Created by Asma Abdulkreem on 12/11/1444 AH.
//

import SwiftUI

struct home: View {
    
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
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
            leading: NavigationLink(destination:profil().navigationBarHidden(true)) {
            Image(systemName: "person")
            .foregroundColor(.white)
            })

                            .navigationBarItems(
                            trailing: NavigationLink(destination:ChatView()) {
                                Image(systemName: "message")
                                    .foregroundColor(.white)
                            })
        }
        
    }
}

struct Destination: Hashable {
    let name, country, imageName: String
}

struct PopularDestinationsView: View {
    
    let destinations: [Destination] = [
        .init(name: "Nasser", country: "Modern, classic, new classic", imageName: "mo"),
        .init(name: "Nasser", country: "Modern, classic, new classic", imageName: "dr"),
        .init(name: "Nasser", country: "Modern, classic, new classic", imageName: "in"),
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
                Spacer()
                VStack(spacing: 8.0) {
                    ForEach(destinations, id: \.self) { destination in
                        VStack(alignment: .leading, spacing: 0) {
                            
                            Image(destination.imageName)
                                .resizable()
                                .scaledToFill()
                            
                                .frame(width: 400, height: 125)
//                                .clipped()
                                .cornerRadius(4)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 6)
                            
                            
                            Text(destination.name)
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 12)
                            
                            Text(destination.country)
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 12)
                                .padding(.bottom, 8)
                                .foregroundColor(.gray)
                        }
                        .background(Color.white)
                            .cornerRadius(5)
                        .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
                            .padding(.bottom)
                    }
                }
                .padding(.horizontal)
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
        .init(name: "Home", imageName: ""),
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
