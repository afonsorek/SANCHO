import Foundation
import SwiftUI

struct ResultsFocusView: View {
    var title: String
    var steps: [String]
    var descs: [String]
    
    @State private var checkedStates: [Bool]
    
    init(title: String, steps: [String], descs: [String]) {
        self.title = title
        self.steps = steps
        self.descs = descs
        self._checkedStates = State(initialValue: Array(repeating: false, count: steps.count))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing: 16) {
                        NavigationLink(destination: AskInputView()) {
                            Image(systemName: "character.bubble.fill")
                                .padding()
                                .frame(width: 36, height: 36)
                                .background(Color(uiColor: .systemGray5))
                                .cornerRadius(18)
                                .foregroundColor(Color(uiColor: .systemGray))
                            VStack(alignment: .leading, spacing: 8) {
                                Text(title)
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
                }
                
                HStack {
                    TabView {
                        ForEach(steps.indices, id: \.self) { index in
                            let item = steps[index]
                            let checked = Binding(
                                get: { checkedStates[index] },
                                set: { checkedStates[index] = $0 }
                            )
                            
                            HStack(alignment: .center) {
                                ZStack(alignment: .center) {
                                    Rectangle()
                                        .foregroundColor(checked.wrappedValue ? Color(uiColor: .green) : Color(uiColor: .systemGray3))
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
                                            .frame(width: 207, height: 400)
                                        Button {
                                            checked.wrappedValue.toggle()
                                        } label: {
                                            Image(systemName: "checkmark.circle.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .padding(4)
                                                .foregroundColor(Color(uiColor: .systemGray))
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.gray, lineWidth: 4)
                                                )
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.clear)
                            }
                            .ignoresSafeArea()
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    .padding(.leading, 72.0)
                    
                    VStack(spacing: 4) {
                        Spacer()
                        HStack{
                            NavigationLink(destination: InventoryView(title: title, steps: steps, descs: descs)) {
                                Image(systemName: "list.bullet.rectangle.portrait.fill")
                                    .font(.title2)
                                    .foregroundColor(Color(uiColor: .gray))
                            }
                        }
                        Rectangle()
                            .opacity(0.0)
                            .frame(width: 0.1, height: 600)
                    }
                }
                .padding(.trailing, 20.0)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct ResultsFocusView_Preview: PreviewProvider {
    static var previews: some View {
        ResultsFocusView(title: "Guardar as roupas", steps: ["Step 1", "Step 2", "Step 3"], descs: ["Desc 1", "Desc 2", "Desc 3"])
    }
}
