import SwiftUI
import OpenAIKit


struct AskInputView: View {
    @State var icone = "character.bubble.fill"
    @State var titulo = "Qual sua tarefa?"
    
    @State var enable = false
    
    @State var label = "square.and.pencil.circle"
    
    @State var titleInv = ""
    @State var arrayInv: [String] = [""]
    @State var arrayDesc: [String] = [""]

    @State private var showingAlert = false
    @State private var prompt = ""
    @State var objetos = ""
    
    @State var itemList: Array<Any> = []
    
    var body: some View {
        NavigationStack{
            ZStack(){
                Rectangle()
                    .foregroundColor(Color(uiColor: .systemGray3))
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 345, height: 290)
                    .cornerRadius(16)
                
                VStack {
                    Image(systemName: icone)
                        .font(.largeTitle)
                        .foregroundColor(Color(uiColor: .darkGray))
                        .frame(width: 68, height: 68, alignment: .center)
                        .background(Color(uiColor: .systemGray3))
                        .cornerRadius(36)
                    
                    Text(titulo)
                        .font(.system(size:30))
                        .fontWeight(.bold)
                        .foregroundColor(Color(uiColor: .darkGray))
                    
                    TextField("Ex.: Quero limpar minha casa", text: $prompt)
                        .foregroundColor(Color(uiColor: .darkGray))
                        .padding(.horizontal,40)
                        .textFieldStyle(.roundedBorder)

                    NavigationLink {
                        ResultsFocusView(title: prompt, steps: arrayInv, descs: arrayDesc)
                    } label: {
                        Image(systemName: label)
                            .font(.title)
                    }
                    .disabled(enable)
                    .onAppear{
                        label = "square.and.pencil.circle"
                        icone = "character.bubble.fill"
                        titulo = "Qual sua tarefa?"
                        prompt = ""
                        enable = true
                    }
                    .onTapGesture {
                        icone = "rectangle.3.group.bubble.left.fill"
                        titulo = "Gerando guia..."
                        label = "rectangle.and.pencil.and.ellipsis"
                        self.addItem()
                        self.enable = true

                    }
                    .padding(.top, 16)
                }
            }
            .ignoresSafeArea()
        }
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
            label = "checkmark.circle"
            titulo = "Guia gerado!"
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
