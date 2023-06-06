//
//  inter1.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 06/06/2023.
//

import SwiftUI

struct inter1: View {
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding(.top,170)
//            Text("Space Beautification")
//                .font(.largeTitle)
//                .foregroundColor(.white)
            Divider()
            Spacer()
        }
        .background(Color("Pr"))
        
    }
    }

struct inter1_Previews: PreviewProvider {
    static var previews: some View {
        inter1()
    }
}
