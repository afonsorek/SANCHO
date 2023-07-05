import SwiftUI
import OpenAIKit


struct AskInputView: View {
    @State var icone = "character.bubble.fill"
    @State var titulo = "Qual sua tarefa?"
    
    @State var enable = false
    @State var animation = false
    
    @State var label = "Criar"
    
    @State var titleInv = ""
    @State var arrayInv: [String] = [""]
    @State var arrayDesc: [String] = [""]

    @State private var showingAlert = false
    @State private var prompt = ""
    @State var objetos = ""
    
    @State var secCheck = false
    
    @State var itemList: Array<Any> = []
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @State var leftOffset: CGFloat = -100
        @State var rightOffset: CGFloat = 100
    
    var body: some View {
        NavigationStack{
            ZStack(){
                VStack(spacing: 40){
                    VStack(spacing: 24){
                        Image("logo-image")
                            .resizable()
                            .frame(width: 68, height: 68)
                            .opacity(0.5)

                        Text(titulo)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(uiColor: .white))
                    }
                    
                    VStack(spacing: 0){
                        TextField("Ex.: Quero limpar minha casa", text: $prompt)
                            .frame(width: 361, height: 36, alignment: .center)
                            .foregroundColor(Color(uiColor: .darkGray))
                            .padding(.horizontal, 40)
                            .textFieldStyle(.roundedBorder)
                            .cornerRadius(1000)
                        
                        NavigationLink {
                            ResultsFocusView(title: prompt, steps: arrayInv, descs: arrayDesc)
                        } label: {
                            if animation == false && secCheck == false{
                                HStack(alignment: .center, spacing: 10) {
                                    Text(label)
                                        .foregroundColor(Color(red: 0.26, green: 0.28, blue: 0.43))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .frame(width: 361, height: 36, alignment: .center)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.26, green: 0.28, blue: 0.43), lineWidth: 1)
                                )
                                
                            }
                            else if animation == false && secCheck == true{
                                HStack(alignment: .center, spacing: 10) {
                                    Text(label)
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                                .frame(width: 361, height: 36, alignment: .center)
                                .background(Color(red: 0.53, green: 0.44, blue: 0.87))
                                .cornerRadius(10)
                            }else{
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 0.26, green: 0.28, blue: 0.43))
                                        .frame(width: 10, height: 10)
                                        .offset(x: leftOffset)
                                        .opacity(0.7)
                                        .animation(Animation.easeInOut(duration: 1))
                                    Circle()
                                        .fill(Color(red: 0.26, green: 0.28, blue: 0.43))
                                        .frame(width: 10, height: 10)
                                        .offset(x: leftOffset)
                                        .opacity(0.7)
                                        .animation(Animation.easeInOut(duration: 1).delay(0.2))
                                    Circle()
                                        .fill(Color(red: 0.26, green: 0.28, blue: 0.43))
                                        .frame(width: 10, height: 10)
                                        .offset(x: leftOffset)
                                        .opacity(0.7)
                                        .animation(Animation.easeInOut(duration: 1).delay(0.4))
                                }
                                .padding(.vertical, 24)
                                .onReceive(timer) { (_) in
                                            swap(&self.leftOffset, &self.rightOffset)
                                        }
                            }
                        }
                        .disabled(enable)
                        .onAppear{
                            label = "Criar"
                            icone = "character.bubble.fill"
                            titulo = "Qual sua tarefa?"
                            prompt = ""
                            enable = true
                        }
                        .onTapGesture {
                            animation = true
                            self.addItem()
                            self.enable = true
                            titulo = "Quase lá..."
                        }
                        .padding(.top, 16)
                    }
                }
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RadialGradient(gradient: Gradient(colors: [Color(red: 0.6, green: 0.72, blue: 0.85), Color(red: 0.73, green: 0.64, blue: 0.85), Color(red: 0.78, green: 0.7, blue: 0.77), Color(red: 0.85, green: 0.78, blue: 0.68)]), center: .topTrailing, startRadius: 0, endRadius: 1200)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
            .ignoresSafeArea()
//            .background(
//            EllipticalGradient(
//            stops: [
//            Gradient.Stop(color: Color(red: 0.6, green: 0.72, blue: 0.85), location: 0.00),
//            Gradient.Stop(color: Color(red: 0.73, green: 0.64, blue: 0.85), location: 0.42),
//            Gradient.Stop(color: Color(red: 0.78, green: 0.7, blue: 0.77), location: 0.63),
//            Gradient.Stop(color: Color(red: 0.85, green: 0.78, blue: 0.68), location: 0.89),
//            ],
//            center: UnitPoint(x: 0.79, y: 0)
//            )
//            )
        }
        .transition(.scale)
        .navigationBarBackButtonHidden()
    }
    
    private func addItem() {
        objetos = ""
        itemList = []
        Task {
            var textFinal = [""]
            let result = await ChatGPTService().getInventory(prompt)
            
            let itemDesc = result!.components(separatedBy: "\n")
            print(itemDesc)
            
            arrayInv = itemDesc[0].components(separatedBy: ", ")
            
            if itemDesc.count == 1{
                arrayDesc = [""]
                print("Descrição veio vazia")
            } else if itemDesc.count == 2{
                arrayDesc = itemDesc[1].components(separatedBy: ", ")
                print("Descrição veio certa teoricamente")
            }else {
                for i in 1 ..< itemDesc.count{
                    textFinal[0] += "\(itemDesc[i]), "
                    arrayDesc = textFinal[0].components(separatedBy: ", ")
                    
                    print("Descrição tentou concatenar com textFinal: \(textFinal)")
                }
            }
            
            print("Items: \(arrayInv)")
            print("Descrições: \(arrayDesc)")
            
            enable = false
            label = "Ver Passos"
            titulo = "Pronto!"
            animation = false
            secCheck = true
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct AskInputView_Previews: PreviewProvider {
    static var previews: some View {
        AskInputView()
    }
}
