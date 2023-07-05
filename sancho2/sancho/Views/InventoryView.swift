//
//  InventoryView.swift
//  sancho
//
//  Created by Nicole Cardoso Machado on 26/06/23.
//

import SwiftUI

struct InventoryView: View {
    var title: String
    var steps: [String]
    var descs: [String]
    @State var count = 0
    
    @State var selectedItems = Set<Int>()
    
    var body: some View {
        NavigationStack{
            
            ZStack(){
                //retângulo com opacidade
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .opacity(0.55)
                
                VStack(){
                    HStack(){
                        NavigationLink{
                            AskInputView()
                            
                        }label:{
                            //ícone
                            Image(systemName: "character.cursor.ibeam")
                                .font(.body)
                                .foregroundColor(Color("Dark Purple"))
                                .frame(width: 40, height: 36, alignment: .center)
                                .background(Color("White"))
                                .cornerRadius(18)
                            
                            //título guardar roupas
                            VStack(alignment: .leading){
                                Text(title)
                                    .multilineTextAlignment(.leading)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Dark Purple"))
                            }
                            //.padding(.leading, 10)
                            
                        }
                        
                    }
                    .padding(.top, 94)
                    
                    //botão flutuante
//                    HStack{
//                        Spacer()
//                        NavigationLink{
//                            ResultsFocusView(title: title, steps: steps, descs: descs)
//                        } label: {
//                            Image(systemName: "sparkles.rectangle.stack.fill")
//                                .font(.title3)
//                                .foregroundColor(Color("White"))
//                                .frame(width: 49, height: 45, alignment: .center)
//                                .background(Color("Dark Purple"))
//                                .cornerRadius(22)
//                        }
//                    }
//                    .padding(.trailing, 5)
                    
                    ScrollView {
                        ZStack{
                            VStack(alignment: .leading, spacing: 24) {
                                ForEach(0..<descs.count, id: \.self) { i in
                                    let isSelected = selectedItems.contains(i)
                                    HStack() {
                                        VStack(alignment: .leading) {
                                            Text(descs[i])
                                                .font(.body)
                                                .foregroundColor(Color("Dark Purple"))
                                        }
                                        
                                        
                                        Spacer()
                                        
                                        Image(systemName: "checkmark")
                                            .font(.body)
                                            .foregroundColor(Color("Dark Purple"))
                                            .opacity(isSelected ? 1 : 0)
                                            .frame(width: 14.3, height: 14.2, alignment: .center)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 9)
                                    .background(isSelected ? Color("White") : .clear)
                                    .frame(maxWidth: 240)
                                    .cornerRadius(4)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                    .inset(by: 0.5)
                                    .stroke(isSelected ? .clear : Color("Light Purple"), lineWidth: 1))
                                    .onTapGesture {
                                        if selectedItems.contains(i){
                                            selectedItems.remove(i)
                                        }
                                        else {
                                            selectedItems.insert(i)
                                        }
                                    }
                                    
                                }
                            }.frame(maxWidth: .infinity)
//                            HStack{
//                                Spacer()
//                                VStack {
//                                    VStack(spacing: 4) {
//                                        // botão de alterar view entre foco e overview
//                                        Button(action: {
//                                            //
//                                        }) {
//                                            Image(systemName: "list.bullet.rectangle.portrait.fill")
//                                                .font(.headline)
//                                                .foregroundColor(Color(uiColor: .systemGray2))
//                                        }
//                                        // 1 primeiro
//                                        // true
//                                        ForEach(0..<steps.count, id: \.self) { i in
//                                            if i == 0{
//                                                VStack(spacing: 0) {
//                                                    ZStack {
//                                                        Circle()
//                                                            .frame(width: 24, height: 24)
//                                                            .foregroundColor(Color(uiColor: .systemGray3))
//                                                        Circle()
//                                                            .frame(width: 12, height: 12)
//                                                            .foregroundColor(Color(uiColor: .systemGray))
//                                                    }
//                                                    Line()
//                                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
//                                                        .frame(width: 2, height: 40)
//                                                        .foregroundColor(Color(uiColor: .systemGray3))
//                                                }
//                                            }else if i == steps.count-1{
//                                                VStack(spacing: 0) {
//                                                    Line()
//                                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
//                                                        .frame(width: 2, height: 47)
//                                                        .foregroundColor(Color(uiColor: .systemGray3))
//                                                    Circle()
//                                                        .frame(width: 12, height: 12)
//                                                        .foregroundColor(.clear)
//                                                        .overlay(content: {
//                                                            Circle()
//                                                                .stroke(Color(uiColor: .systemGray3), lineWidth: 2)
//                                                    })
//                                                }
//                                            }else{
//                                                VStack(spacing: 0) {
//                                                    Circle()
//                                                        .frame(width: 12, height: 12)
//                                                        .foregroundColor(.clear)
//                                                        .overlay(content: {
//                                                            Circle()
//                                                                .stroke(Color(uiColor: .systemGray3), lineWidth: 2)
//                                                    })
//                                                    Line()
//                                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
//                                                        .frame(width: 2, height: 40)
//                                                        .foregroundColor(Color(uiColor: .systemGray3))
//                                                }
//                                            }
//                                        }
//                                    }
//                                }
//                            }.padding(.horizontal, 48)
                        }
                    }
                }
                
                .padding(.horizontal, 23)
               
            }
            //gradiente de fundo
            .background(
                RadialGradient(gradient: Gradient(colors: [Color(red: 0.6, green: 0.72, blue: 0.85), Color(red: 0.73, green: 0.64, blue: 0.85), Color(red: 0.78, green: 0.7, blue: 0.77), Color(red: 0.85, green: 0.78, blue: 0.68)]), center: .topTrailing, startRadius: 0, endRadius: 1200)
            .frame(maxWidth: .infinity, maxHeight: .infinity))
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView(title: "Quero levar o meu carro em um mecânico", steps: [""], descs: ["Comece aqui", "Comece"])
    }
}
