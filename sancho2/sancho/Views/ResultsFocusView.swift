
//
//  ResultsFocus.swift
//  sancho
//
//  Created by Jady Torralvo on 27/06/23.
//

import Foundation
import SwiftUI

struct ResultsFocusView: View {
    var title: String
    var steps: [String]
    var descs: [String]
    var body: some View {
        
        // ZStack: lvl 1 -> título + navbar + main button // lvl 2 -> HStack cards
        NavigationView{
            ZStack{
                VStack {
                    HStack(spacing: 16) {
                        NavigationLink{
                            AskInputView()
                        } label:{
                            Image(systemName: "character.bubble.fill")
                                .padding()
                                .frame(width: 36, height: 36)
                                .background(Color(uiColor: .systemGray5))
                                .cornerRadius(18)
                                .foregroundColor(Color(uiColor: .systemGray))
                            VStack(alignment: .leading, spacing: 8){
                                Text("Guardar as roupas") //<- precisa inserir o texto variável (input da tarefa) ---> é o $prompt
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(uiColor: .systemGray))
                                Text("Siga esses passos.")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(uiColor: .systemGray))
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .padding(4)
                            .foregroundColor(Color(uiColor: .systemGray))
                            .overlay(content: {
                                Circle()
                                    .stroke(.gray, lineWidth: 4)
                            })
                    }
                }
                
                
                // HStack adicionar CardView + lógica do spacer fixo atrás da navbar
                
                // título
                
                HStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(steps, id: \.self){ item in
                                HStack (alignment: .center){
                                    ZStack (alignment: .center){
                                        Rectangle()
                                            .foregroundColor(Color(uiColor: .systemGray3))
                                            .frame(width: 207, height: 526)
                                            .cornerRadius(16)
                                            .padding(.leading, 8)
                                            .padding(.trailing, 8)
                                            .alignmentGuide(.leading) { dimensions in
                                                -dimensions.width / 2
                                            }
                                        
                                        VStack(alignment: .center) {
                                            Text(item)
                                                .font(.body)
                                                .foregroundColor(Color(uiColor: .black))
                                                .multilineTextAlignment(.center)
                                        }
                                        
                                        
                                    }
                                    .padding(.horizontal, 16)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(.clear)
                                }.ignoresSafeArea()
                            }
                        }
                    }
                    .padding(.leading, 72.0)
                    
                    VStack(spacing: 4) {
                        // botão de alterar view entre foco e overview
                        NavigationLink{
                            InventoryView(title: title, steps: steps, descs: descs)
                        } label: {
                            Image(systemName: "list.bullet.rectangle.portrait.fill")
                                .font(.headline)
                                .foregroundColor(Color(uiColor: .systemGray2))
                        }
                    }
                }
                .padding(.trailing, 20.0)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        return path
    }
}

struct ResultsFocusView_Preview: PreviewProvider {
    static var previews: some View {
        ResultsFocusView(title: "Guardar as roupas", steps: [""], descs: [""])
    }
}
