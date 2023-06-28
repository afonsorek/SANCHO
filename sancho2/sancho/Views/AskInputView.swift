import SwiftUI
import OpenAIKit


struct AskInputView: View {
    @State var icone = "character.bubble.fill"
    @State var titulo = "Qual sua tarefa?"
    
    @State var activeNav = true
    
    @State var titleInv = ""
    @State var arrayInv: [String] = [""]

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
                    
                    Button("Enviar"){
                        icone = "rectangle.3.group.bubble.left.fill"
                        titulo = "Gerando guia..."
                        addItem()
                    }
                    NavigationLink {
                        InventoryView(title: prompt, steps: arrayInv)
                    } label: {
                        Text("Ver tarefa")
                    }
                    .disabled(activeNav)
                }
                
            }
            .ignoresSafeArea()
        }
        .onAppear{
            icone = "character.bubble.fill"
            titulo = "Qual sua tarefa?"
            activeNav = true
        }
    }
    
    private func addItem() {
        objetos = ""
        itemList = []
        Task {
            let result = await ChatGPTService().getInventory(prompt)
                                
            arrayInv = result!.components(separatedBy: ", ")
            print(arrayInv)
            
            activeNav = false
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
