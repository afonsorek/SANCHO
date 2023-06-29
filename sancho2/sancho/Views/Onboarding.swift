//
//  Onboarding.swift
//  sancho
//
//  Created by Jady Torralvo on 04/07/23.
//

import SwiftUI

struct Onboarding: View {
    
    @State var dataModel = DataModel()
    
    var body: some View {
    
        ZStack {
            VStack (spacing: 48){
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                    VStack (alignment: .center, spacing: 8){
                        VStack(spacing: 56){
                            Image("Logo")
                                .opacity(0.7)
                            Text("Spark te ajuda a cumprir suas metas levando em conta as dificuldades do TDAH.")
                                .frame(width: 303)
                                .foregroundColor(Color("DarkPurple"))
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        TabView {
                            ForEach(dataModel.pages) { page in
                                HStack(spacing: 8){
                                    Image(systemName: page.icon)
                                        .foregroundColor(Color("Purple"))
                                        .font(.largeTitle)
                                        .fontWeight(.regular)
                                    Text(page.text)
                                        .frame(width: 244)
                                        .foregroundColor(Color("DarkPurple"))
                                        .font(.title3)
                                        .fontWeight(.bold)
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(height: 200)
                    }
                
                    Button(action: {
                       // ir pro AskInputView
                    }) {
                        Text("Começar")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color("White"))
                            .padding()
                            .frame(width: 260)
                            .background(Color("Purple"))
                            .cornerRadius(12)
                    }
                Spacer()
            }
        }
        .background(
            RadialGradient(gradient: Gradient(colors: [Color(red: 0.6, green: 0.72, blue: 0.85), Color(red: 0.73, green: 0.64, blue: 0.85), Color(red: 0.78, green: 0.7, blue: 0.77), Color(red: 0.85, green: 0.78, blue: 0.68)]), center: .topTrailing, startRadius: 0, endRadius: 1200)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
        .ignoresSafeArea()
    }
}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
