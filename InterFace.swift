//
//  InterFace.swift
//  InteriorDesigner
//
//  Created by AtheerAlshehri on 06/06/2023.
//

import SwiftUI

struct InterFace: View {
    var body: some View {
        VStack {
            Image("logo1")
                .padding(.top,130)
            //    .padding(.trailing,10)
            Divider()
            Spacer()
        }
        .background(Color("pr2"))
    }
    }


struct InterFace_Previews: PreviewProvider {
    static var previews: some View {
        InterFace()
    }
}
