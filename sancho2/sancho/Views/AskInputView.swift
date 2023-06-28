import SwiftUI
import CoreData
import OpenAIKit


struct AskInputView: View {
    @State var icone = "character.bubble.fill"
    @State var titulo = "Qual sua tarefa?"
    
    @State var activeNav = true
    
    @State var titleInv = ""
    @State var arrayInv: [String] = [""]
    
    @State var sameItems: Tarefa
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Inventory.raw, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Inventory>

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
                        InventoryView(title: titleInv, steps: arrayInv)
                    } label: {
                        Text("Ver tarefa")
                    }
                    .disabled(activeNav)
                }
                
            }
            .ignoresSafeArea()
        }
        .onAppear{activeNav = true}
    }
    
    private func addItem() {
        objetos = ""
        itemList = []
        Task {
            let result = await ChatGPTService().getInventory(prompt)
            
            withAnimation {
                let newInventory = Inventory(context: viewContext)
                newInventory.title = prompt
                newInventory.raw = result
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                for item in items{
                    do {
                        let decoder = JSONDecoder()
                        let data = Data(item.raw?.utf8 ?? "".utf8)
                        
                        sameItems = try decoder.decode(Tarefa.self, from: data)
                        
                        for item in sameItems.items{
                            itemList.append(item.values.description)
                        }
                        
                        for i in (0 ... itemList.count-1){
                            objetos += "\(itemList[i])"
                        }
                        
                        objetos.replace("[\"", with: " ")
                        objetos.replace("\"]", with: "   ")
                        print(objetos)
                        
                        titleInv = item.title ?? ""
                        arrayInv = objetos.components(separatedBy: "   ")
                        print("titleInv: \(titleInv)")
                        print("ArrayInv: \(arrayInv)")
                        activeNav = false
                        
                    }catch {
                        print("Erro: \(error)")
                    }
                }
            }

        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
        AskInputView(sameItems: Tarefa(task: "", items: [["" : ""]])).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
