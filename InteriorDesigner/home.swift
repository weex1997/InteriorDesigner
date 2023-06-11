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
        GeometryReader{ geo in
          
            NavigationView {
                
                ScrollView {
                      
                    
                                VStack{
                                       
                                    VStack{
                                        Text("Welcome \(viewModel.user.name ?? "")")
                                            .font(.subheadline)
                                            .foregroundColor(Color("line"))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()                        }
                                    
                                    VStack{
                                        Text("Let's Find Your Designer.")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()                        }
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                        Text("Search by style or designer name.")
                                        Spacer()
                                        
                                    }.font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color(.init(white: 1, alpha: 0.3)))
                                        .cornerRadius(10)
                                        .padding(16)
                                    
                                }       .frame(height: 307)            .background(Image("HomeHeader")
                                    .resizable()
                                        .aspectRatio(UIImage(named: "HomeHeader")!.size, contentMode: .fill)
                                )
                                    .cornerRadius(10)
                                Color(.init(white: 0.95, alpha: 1))
                                    .offset(y: 400)
                    VStack{
                        FilterPicker()
                    }                            .padding(.leading, 35.0)
                    VStack{
                        PopularDestinationsView()
                    }.padding(.leading, 26.0)

                            

                }.background(Color(.init(white: 0.95, alpha: 1)))
                .edgesIgnoringSafeArea(.top)
                
                
                
                
                .navigationBarItems(
                    
                    trailing:
                        
                        Button {
                            showSheet = true
                            showProfile = true
                            print(self.viewModel.user.desinger)
                        } label: {
                            if ((userIDE) != nil) {
                                if(self.viewModel.user.desinger == true){
                                    NavigationLink(destination:ContentView(),isActive: $showProfile){}}
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
                
                .navigationBarItems(
                    trailing:
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
                
            }.onAppear(){
                self.viewModel.getData()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(false)
            .accentColor(Color("Primary"))
        }
        
    }
}



struct PopularDestinationsView: View {
    @State var im = ""
    @StateObject var viewModel = ViewModel()
//    let items = ["Houses", "Coffee"]
//    let filteredBooks = viewModel.designers.filter { items.contains($0.field) }
//    if (d.field.contains("Houses")) {
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                ForEach(self.viewModel.designers, id: \.id) { d in
//                    if (d.field.contains("Houses")){
                        NavigationLink(destination: OtherDesinerPage(users:.init(id:d.id,name: d.name,gender:d.gender, desinger: d.desinger, brief: d.brief, field: d.field, styles: d.styles, rate: d.rate, images: d.images)).navigationBarBackButtonHidden(false)){
                            VStack( spacing: 0) {
                                VStack{
                                    if 0 == d.images.count {
                                        
                                        AsyncImage(url: URL(string: "" ))
                                            { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 327, height: 154)
                                                    .cornerRadius(4)
                                                    .padding(.horizontal, 6)
                                                    .padding(.vertical, 6)
                                                
                                            } placeholder: {
                                                Color.gray
                                                    .scaledToFill()
                                                    .frame(width: 327, height: 154)
                                                    .cornerRadius(4)
                                                    .padding(.horizontal, 6)
                                                    .padding(.vertical, 6)                                         }
                                        
                                    }else{


                                    
                                    AsyncImage(url: URL(string: d.images[0] ))
                                        { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 327, height: 154)
                                                .cornerRadius(4)
                                                .padding(.horizontal, 6)
                                                .padding(.vertical, 6)
                                            
                                        } placeholder: {
                                            Color.gray
                                                .scaledToFill()
                                                .frame(width: 327, height: 154)
                                                .cornerRadius(4)
                                                .padding(.horizontal, 6)
                                                .padding(.vertical, 6)   
                                                                               }
                                    }
                                }
                                VStack(alignment: .leading){
                                    Text(d.name)
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                        .padding(.horizontal, 12)
                                        .padding(.bottom, 8)
                                    
                                    HStack{
                                        Text(d.styles)
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
                                        Text("\(d.rate).00")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.gray)
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.yellow)
                                    }.padding(.horizontal, 12)
                                        .padding(.bottom, 8)
                                }
                            }
                            
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 0)
                        }.padding(.vertical, 10)
                    }
//                    }
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


struct FilterPicker: View {
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    
    @State var selectedItems: [Items] = []
    @State var ff = [""]
    
    var body: some View {
          
                ScrollView(.horizontal) {
                    
                    LazyHGrid(rows: rows) {
                        
                        ForEach(Items.allCases, id: \.self) { item in
                            FilterColumn(item: item, items: $selectedItems)
                            
                        }
                        
                    }
                    
                }
        }
}


struct FilterColumn:View {
    @State var item: Items
    @Binding var items: [Items]

    var body: some View {
        
        Button(action: {
            if items.contains(item) {
                items.removeAll { $0 == item}

                
            } else {
                items.append(item)

                
            }
            print(items)


        }, label: {
            Text(item.rawValue)
                .foregroundColor(Color.white)
        })
        .frame(width: 90, height: 28)
        .background(items.contains(item) ? Color("Primary") : Color("line"))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

