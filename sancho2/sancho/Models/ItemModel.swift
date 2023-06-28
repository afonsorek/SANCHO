//
//  ItemModel.swift
//  sancho
//
//  Created by Afonso Rekbaim on 26/06/23.
//

import Foundation

public struct Tarefa: Codable {
    var task: String
    var items: [[String: String]]
}
