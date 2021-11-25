//
//  financa.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 18/11/21.
//

import Foundation

struct Financa: Codable {
    let id: Int
    let idUser: Int
    let tipo: String
    let dataMovimentacao: String
    let descricao: String
    let categoria: String
    let valor: Double
}
