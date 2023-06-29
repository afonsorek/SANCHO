//
//  ChatGPTService.swift
//  sancho
//
//  Created by Felipe Passos on 23/06/23.
//

import Foundation
import OpenAIKit

class ChatGPTService: ObservableObject {
    private var client: OpenAIKit.Client
    
    private var prompt: String = """
        Com base na tarefa explicada abaixo, categorize e gere itens que devem ser utilizados na determinada tarefa.

        Retorne apenas os objetos necessários separados por vírgula.
        Uma única string na mesma linha.
    
        Me dê uma descrição em passos enumerados sobre o processo requisitado, utilizando os objetos citados em ordem de execução.
        Sempre coloque "Passo x: " antes do passo e os separe com vírgulas.
        Uma única string na mesma linha com todos os passos em forma de texto separados por vírgula.
        Me entregue somente texto na mesma linha.

        Retorne o processo em ordem de execução.
    
        Exemplo de resultado esperado caso a tarefa fosse "Fazer brigadeiro":
        Panela, Colher, Leite-Condesado, Chocolate em pó, Manteiga
        Passo 1: Panela em fogo baixo, Passo 2: Utiliza a colher para misturar os ingredientes, Passo 3: Adicione uma caixa de Leite Condensado, Passo 4: Adicione duas colheres de chocolate em pó, Passo 5: Adione uma colher de manteiga
    
        Exemplo de resultado esperado caso a tarefa fosse "Quero limpar a casa":
        Vassoura, Pá, Saco de Lixo
        Passo 1: Varra o cômodo por completo, Passo 2: Utilize a pazinha para recolher o lixo, Passo 3: Jogue o lixo no saco
        
    """
    
    init() {
        client = OpenAIKit.Client(
            session: URLSession(configuration: .default),
            configuration: Configuration(
                apiKey: "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",
                organization: "")
            )
    }
    
    func getInventory(_ input: String) async -> String? {
        do {
            let chat = try await client.chats.create(
                model: Model.GPT3.gpt3_5Turbo,
                messages: [
                    .assistant(content: prompt),
                    .user(content: input)
                ]
            )
            
            if let response = chat.choices.first?.message.content {
                return response
            }
        } catch {
            print(error)
            return nil
        }
        
        return nil
    }
}
