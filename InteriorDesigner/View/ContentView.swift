//
//  ContentView.swift
//  InteriorDesigner
//
//  Created by Wedad Almehmadi on 14/05/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        GeometryReader {
                           let size = $0.size
                           let safeArea = $0.safeAreaInsets
                           
                   designerProfile(size: size, safeArea: safeArea)
                               .ignoresSafeArea(.all, edges: .top)
                       }
            }
        }

struct ContentGPTView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
