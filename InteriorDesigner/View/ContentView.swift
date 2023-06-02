//
//  ContentView.swift
//  InteriorDesigner
//
//  Created by Wedad Almehmadi on 14/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
//            designerProfile(size: size, safeArea: safeArea)
            home()
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
