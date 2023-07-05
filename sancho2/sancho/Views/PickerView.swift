//
//  PickerView.swift
//  sancho
//
//  Created by Afonso Rekbaim on 05/07/23.
//

import Foundation
import SwiftUI

struct PickerView: View {
    @State var selection = false
    
    var title: String
    var steps: [String]
    var descs: [String]
    
    var body: some View {
        NavigationStack{
            ZStack{
                if selection == false{
                    ResultsFocusView(title: title, steps: steps, descs: descs)
                }else{
                    InventoryView(title: title, steps: steps, descs: descs)
                }
                VStack {
                    Picker("View", selection: $selection) {
                        Text("Itens").tag(false)
                        Text("Passos").tag(true)
                    }.pickerStyle(.segmented)
                    Spacer()
                }
            }
            
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(title: "Título", steps: ["Step 1", "Step 2", "Step 3"], descs: ["Desc 1", "Desc 2", "Desc 3"])
    }
}
