//
//  CardView.swift
//  sancho
//
//  Created by Theo Henrique Silva on 28/06/23.
//

import SwiftUI

struct CardView: View {
    var title: String
    var steps: [String]
    var body: some View {
        NavigationStack{
            
            ZStack(){
                //coloca o fundo cinza
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color(uiColor: .white))
                
                //retangulo branco do fundo
                VStack {
                
                }
                
                
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
                        VStack(alignment: .center){
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
                        Image(systemName: "list.bullet.rectangle.portrait.fill")
                            .font(.body)
                            .foregroundColor(Color(uiColor: .darkGray))
                            .frame(width: 36, height: 36, alignment: .center)
                    }
                    .padding(.horizontal, 45)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(steps, id: \.self){ item in
                                HStack {
                                    ZStack (alignment: .center){
                                        Rectangle()
                                            .foregroundColor(Color(uiColor: .systemGray3))
                                            .frame(width: 207, height: 526)
                                            .cornerRadius(16)
                                            .padding(.leading, 8)
                                            .padding(.trailing, 8)
                                        
                                        VStack(alignment: .center) {
                                            Text(item)
                                                .font(.largeTitle)
                                                .foregroundColor(Color(uiColor: .black))
                                                .multilineTextAlignment(.center)
                                            
                                            Text("Descrição do item x")
                                                .multilineTextAlignment(.center)
                                                .font(.headline)
                                            
                                        }
                                        .padding(.bottom, 33)
                                        
                                    }
                                        .padding(.horizontal, 16)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(.clear)
                                    }.ignoresSafeArea()
                                }
                        }
                    }
                }
                
                .padding(.top, 48)
            }
        }
    }
}
    

    
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Guardar as roupas", steps: [""])
    }
}
