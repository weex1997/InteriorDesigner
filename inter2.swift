//
//  inter1.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 06/06/2023.
//

import SwiftUI

struct inter2: View {
    var body: some View {
        VStack {
            Image("logo2")
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

struct inter2_Previews: PreviewProvider {
    static var previews: some View {
        inter2()
    }
}
