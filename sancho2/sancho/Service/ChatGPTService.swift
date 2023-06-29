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
    
        Na linha abaixo, retorne uma breve descrição com o menor número possível de palavras sobre a função do item correspondente no processo.

        Exemplo de resultado esperado caso a tarefa fosse "Quero lavar roupa":
        Amaciante, Máquina de Lavar, Sabão em Pó, Água, Prendedores, Varal
        Para aromatizar a roupa, Para realizar o processo pesado, Para limpeza das roupas, Para lavar a roupa, Para prendrer a roupa no varal, Para estender a roupa
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
