import SwiftUI
import CoreData
import OpenAIKit

struct ContentView: View {
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
        NavigationView {
            VStack {
                Spacer()
                List {
                    ForEach(items) { item in
                        NavigationLink {
                            //Text(sameItems.items.first?.values.first ?? "")
                            Text(objetos)
                            //Text(item.)
                        } label: {
                            Text(item.title ?? "")
                        }.onAppear {
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
                                objetos.replace("\"]", with: " \n")
                                
                            } catch {
                                print("Erro: \(error)")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: {
                            showingAlert.toggle()
                        }, label: {
                            Label("Add Item", systemImage: "plus")
                        })
                        .alert("Fale com o ChatGPT", isPresented: $showingAlert) {
                            TextField("Ex.: Quero limpar minha casa", text: $prompt)
                            Button("Enviar") {
                                addItem()
                            }
                        } message: {
                            Text("Digite aqui qual tarefa deseja realizar")
                        }
                    }
                }
            }
        }
    }

    private func addItem() {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sameItems: Tarefa(task: "", items: [["" : ""]])).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
