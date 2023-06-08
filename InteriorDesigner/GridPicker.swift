//
//  SwiftUIView.swift
//  InteriorDesigner
//
//  Created by Wedad Almehmadi on 06/06/2023.
//

import SwiftUI

enum Items: String, CaseIterable, Equatable {
    case Houses = "Houses"
    case Cofe = "Cofe"
    case Resturant = "Resturant"

}

struct GridPicker: View {
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    
    @State var selectedItems: [Items] = []
    @State var ff = [""]
    
    var body: some View {
          
                ScrollView(.horizontal) {
                    
                    LazyHGrid(rows: rows) {
                        
                        ForEach(Items.allCases, id: \.self) { item in
                            GridColumn(item: item, items: $selectedItems)
                            
                        }
                        
                    }
                    
                }
        }
}

struct GridPicker_Previews: PreviewProvider {
    static var previews: some View {
        GridPicker()
    }
}


struct GridColumn:View {
    @State var item: Items
    @Binding var items: [Items]
    @StateObject var viewModel = ViewModel()

    var body: some View {
        
        Button(action: {
            if items.contains(item) {
                items.removeAll { $0 == item}

                viewModel.removeFieldArray(Feilds: item.rawValue)
                
            } else {
                items.append(item)
                viewModel.addFieldArray(Feilds: item.rawValue)

                
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


