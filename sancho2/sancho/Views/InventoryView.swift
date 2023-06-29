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
                        ZStack{
                            VStack {
                                //                            ForEach(steps, id: \.self){ item in
                                ForEach(0..<steps.count, id: \.self) { i in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(steps[i])
                                                .font(.body)
                                                .foregroundColor(Color(uiColor: .black))
                                            if i < descs.count{
                                                Text(descs[i])
                                                    .font(.caption)
                                                    .opacity(0.6)
                                            }else{
                                                Text("--")
                                                    .font(.caption)
                                                    .opacity(0.6)
                                            }
                                            
                                            if i == descs.count-1{
                                                //
                                            }else{
                                                //Divider()
                                            }
                                        }
                                        .padding(.bottom, 33)
                                        Spacer()
                                            if i == 0{
                                                VStack(spacing: 0) {
                                                    ZStack {
                                                        Circle()
                                                            .frame(width: 24, height: 24)
                                                            .foregroundColor(Color(uiColor: .systemGray3))
                                                        Circle()
                                                            .frame(width: 12, height: 12)
                                                            .foregroundColor(Color(uiColor: .systemGray))
                                                            .frame(width: 24, height: 24)
                                                    }
                                                    Line()
                                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                        .frame(width: 2, height: 40)
                                                        .foregroundColor(Color(uiColor: .systemGray3))
                                                }
                                            }else if i == steps.count-1{
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
                                                        .frame(width: 24, height: 24)
                                                }
                                            }else{
                                                VStack(spacing: 0) {
                                                    Line()
                                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                        .frame(width: 2, height: 20)
                                                        .foregroundColor(Color(uiColor: .systemGray3))
                                                    Circle()
                                                        .frame(width: 12, height: 12)
                                                        .foregroundColor(.clear)
                                                        .overlay(content: {
                                                            Circle()
                                                                .stroke(Color(uiColor: .systemGray3), lineWidth: 2)
                                                    })
                                                        .frame(width: 24, height: 24)
                                                    Line()
                                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                                                        .frame(width: 2, height: 20)
                                                        .foregroundColor(Color(uiColor: .systemGray3))
                                                }
                                            }
                                    }
                                    .padding(.horizontal, 45)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(.clear)
                                }
                            }
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
                
                .padding(.top, 48)
            }
        }
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView(title: "Guardar as roupas", steps: [""], descs: [""])
    }
}
