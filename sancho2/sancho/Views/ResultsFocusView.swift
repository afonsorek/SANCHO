import Foundation
import SwiftUI

struct ResultsFocusView: View {
    var title: String
    var steps: [String]
    var descs: [String]
    
    @State private var checkedStates: [Bool]
    @State private var currentStep = 0
    
    init(title: String, steps: [String], descs: [String]) {
        self.title = title
        self.steps = steps
        self.descs = descs
        self._checkedStates = State(initialValue: Array(repeating: false, count: steps.count))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()

                     .frame(maxWidth: .infinity,maxHeight: .infinity)
                     .foregroundColor(Color(uiColor: .white))
                     .ignoresSafeArea()
                     .opacity(0.55)
                    
                
                VStack {
                    HStack {
                        NavigationLink {
                            AskInputView()
                        } label: {
                                Image(systemName: "chevron.left")
                                    .bold()
                                    .frame(alignment: .leading)
                                    .padding(.vertical,8)
                                    .frame(width: 36, height: 36)
                                    .background(Color(uiColor: .white))
                                    .cornerRadius(18)
                                    .foregroundColor(Color("Dark Purple"))
                    }
                        Spacer()
                            
                    } .padding(.leading, 16)
                      .padding(.top, 64)
                      .padding(.top, 10)
                    Text(title)
                        .frame(maxWidth: 290)
                        .multilineTextAlignment(.leading)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Dark Purple"))
                        
                    
                    Spacer()
                        .padding(.leading, 16.0)
                    
                    
                    
                }
                
               
                
                HStack {
                    TabView(selection: $currentStep) {
                        ForEach(steps.indices, id: \.self) { index in
                            let item = steps[index]
                            let checked = Binding(
                                get: { checkedStates[index] },
                                set: { checkedStates[index] = $0 }
                            )
                            
                            HStack(alignment: .center) {
                                ZStack(alignment: .center) {
                                    Rectangle()
                                        .foregroundColor(checked.wrappedValue ? Color(uiColor: .white).opacity(0): Color(uiColor: .white))
                                        .frame(width: 207, height: 526)
                                        .cornerRadius(16)
                                        .padding(.leading, 8)
                                        .padding(.trailing, 8)
                                        .alignmentGuide(.leading) { dimensions in
                                            -dimensions.width / 2
                                        }
                                        .border(checked.wrappedValue ? Color("Purple") : Color(uiColor: .white).opacity(0)) // como eu coloco a borda arredondada nisso?
                                    
                                    
//                                        .cornerRadius(checked.wrappedValue ? 15 : 16)
                                    
                                    VStack(alignment: .center) {
                                        Text(item)
                                            .font(.title)
                                            .bold()
                                            .foregroundColor(Color("Dark Purple"))
//                                            .multilineTextAlignment(.leading)
                                            .frame(width: 207, height: 400)
//                                            .frame(maxWidth: 240)

                                        Button {
                                            withAnimation {
                                                checked.wrappedValue.toggle()
                                                currentStep += 1
                                                if currentStep >= 3 {
                                                    currentStep = 0
                                                }
                                                
                                            }
                                        } label: {
                                            Image(systemName: checked.wrappedValue ? "checkmark.circle.fill" : "circle")
                                                .resizable()
                                                .font(.title)
                                                .frame(width: 36, height: 36)
                                                
                                                .padding(4)
                                                .foregroundColor(Color("Purple"))
                                                
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.clear)
                            }
                            .ignoresSafeArea()
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    .padding(.leading, 72.0)
                    
                    VStack(spacing: 4) {
                        Spacer()
                        NavigationLink{
                            InventoryView(title: title, steps: steps, descs: descs)
                        } label: {
                        HStack{
                                Image(systemName: "sparkles.tv.fill")
                                    .font(.title3)
                                    .frame(width: 49, height: 45)
                                    .background(Color("Dark Purple"))
                                    .cornerRadius(22)
                                    
                            }.disabled(true)
                                .opacity(0)
                        }
                        Rectangle()
                            .opacity(0.0)
                            .frame(width: 0.1, height: 34)
                    }
                }
                .padding(.trailing, 20.0)
            }
            .background(
                  RadialGradient(gradient: Gradient(colors: [Color(red: 0.6, green: 0.72, blue: 0.85), Color(red: 0.73, green: 0.64, blue: 0.85), Color(red: 0.78, green: 0.7, blue: 0.77), Color(red: 0.85, green: 0.78, blue: 0.68)]), center: .topTrailing, startRadius: 0, endRadius: 1200)
                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                              )
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

struct ResultsFocusView_Preview: PreviewProvider {
    static var previews: some View {
        ResultsFocusView(title: "Guardar as roupas", steps: ["Step 1", "Step 2", "Step 3"], descs: ["Desc 1", "Desc 2", "Desc 3"])
    }
}
