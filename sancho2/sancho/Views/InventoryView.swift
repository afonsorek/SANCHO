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
    var body: some View {
        NavigationStack{
            
            ZStack(){
                //coloca o fundo cinza
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color(uiColor: .systemGray3))
                
                //retangulo branco do fundo
                VStack(alignment: .center, spacing: 13){
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .padding(.horizontal,25)
                        .padding(.top,75)
                }
                .ignoresSafeArea()
                VStack {
                    HStack(alignment: .center, spacing: 16){
                        //ICONE
                        Image(systemName: "character.bubble.fill")
                            .font(.body)
                            .foregroundColor(Color(uiColor: .darkGray))
                            .frame(width: 36, height: 36, alignment: .center)
                            .background(Color(uiColor: .systemGray3))
                            .cornerRadius(36)
                        
                        //título guardar roupas e subtítulo
                        VStack(alignment: .leading, spacing: 8){
                            Text(title)
                                .font(.title)
                                .fontWeight(.bold)
                                .kerning(0.36)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(uiColor: .darkGray))
                            
                            Text("Siga esses passos.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(uiColor: .darkGray))
                        }
                        
                    }
                    .padding(0)
                    
                    HStack{
                        Spacer()
                        Image(systemName: "rectangle.3.group.fill")
                            .font(.body)
                            .foregroundColor(Color(uiColor: .darkGray))
                            .frame(width: 36, height: 36, alignment: .center)
                    }
                    .padding(.horizontal, 45)
                    ScrollView {
                        VStack {
                            ForEach(steps, id: \.self){ item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item)
                                            .font(.body)
                                            .foregroundColor(Color(uiColor: .black))
                                        Text("Descrição do item x")
                                            .font(.caption)
                                            .opacity(0.6)
                                        Divider()
                                    }
                                    .padding(.bottom, 33)
                                }
                                .padding(.horizontal, 45)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.clear)
                            }
                        }
                    }
                }
                
                .padding(.top, 48)
            }
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView(title: "Guardar as roupas", steps: [""])
    }
}
