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

        Exemplo de resultado esperado caso a tarefa fosse "Quero lavar roupa":
        Amaciante, Máquina de Lavar, Sabão em Pó, Água, Prendedores, Varal
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
