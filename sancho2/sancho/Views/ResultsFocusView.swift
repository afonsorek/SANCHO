//
//  ResultsFocus.swift
//  sancho
//
//  Created by Jady Torralvo on 27/06/23.
//

import Foundation
import SwiftUI

struct ResultsFocusView: View {
    var steps: [String]
    
    var body: some View {
        
        // ZStack: lvl 1 -> título + navbar + main button // lvl 2 -> HStack cards
        
        ZStack{
            HStack{
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
            HStack(alignment: .center){
                
                
                
                // 1 card apenas (precisa ser padronizado ne? Fazer em outro file)
                //                VStack {
                //                    .frame(width: 207, height: 528)
                //                }
                
                
                
            }
            
            // título
            VStack {
                HStack(spacing: 16) {
                    Button(action: {}) {
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
            
            
            VStack(spacing: 4) {
                // botão de alterar view entre foco e overview
                Button(action: {}) {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.headline)
                        .foregroundColor(Color(uiColor: .systemGray2))
                }
                
                // VStack(spacing: 0) {
                // aqui aparece
                // 1o -> lógica da quantidade de steps
                // 2o -> lógica de qual o tipo (de 1 a 4)
                // 3o -> lógica de se o step é true ou false
                
                
                // 1 primeiro
                // true
                VStack(spacing: 0) {
                    ZStack {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(uiColor: .systemGray3))
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(uiColor: .systemGray))
                    }
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 40)
                        .foregroundColor(Color(uiColor: .systemGray3))
                }
                //false
                VStack(spacing: 0) {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.clear)
                        .overlay(content: {
                            Circle()
                                .stroke(Color(uiColor: .systemGray3), lineWidth: 2)
                    })
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 40)
                        .foregroundColor(Color(uiColor: .systemGray3))
                }
                
                // 2 segundo
                // true
                VStack(spacing: 0) {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 25)
                        .foregroundColor(Color(uiColor: .systemGray3))
                    ZStack {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(uiColor: .systemGray3))
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(uiColor: .systemGray))
                    }
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 30)
                        .foregroundColor(Color(uiColor: .systemGray3))
                }
                // false
                VStack(spacing: 0) {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 37)
                        .foregroundColor(Color(uiColor: .systemGray3))
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.clear)
                        .overlay(content: {
                            Circle()
                                .stroke(Color(uiColor: .systemGray3), lineWidth: 2)
                    })
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 30)
                        .foregroundColor(Color(uiColor: .systemGray3))
                }
                
                // 3 terceiro
                // true
                VStack(spacing: 0) {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 35)
                        .foregroundColor(Color(uiColor: .systemGray3))
                    ZStack {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(uiColor: .systemGray3))
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(uiColor: .systemGray))
                    }
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 30)
                        .foregroundColor(Color(uiColor: .systemGray3))
                }
                // false
                VStack(spacing: 0) {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 47)
                        .foregroundColor(Color(uiColor: .systemGray3))
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.clear)
                        .overlay(content: {
                            Circle()
                                .stroke(Color(uiColor: .systemGray3), lineWidth: 2)
                    })
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 30)
                        .foregroundColor(Color(uiColor: .systemGray3))
                }
                
                // 4 ultimo
                // true
                VStack(spacing: 0) {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 35)
                        .foregroundColor(Color(uiColor: .systemGray3))
                    ZStack {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(uiColor: .systemGray3))
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(uiColor: .systemGray))
                    }
                }
                //false
                VStack(spacing: 0) {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                        .frame(width: 2, height: 47)
                        .foregroundColor(Color(uiColor: .systemGray3))
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.clear)
                        .overlay(content: {
                            Circle()
                                .stroke(Color(uiColor: .systemGray3), lineWidth: 2)
                    })
                }
            }
        }
    }
}

struct ResultsFocusView_Preview: PreviewProvider {
    static var previews: some View {
        ResultsFocusView(steps: [""])
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
