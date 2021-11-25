//
//  financaBack.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 24/11/21.
//

import Foundation

struct FinancaBack: Codable {
    let id: Int
    let idUser: Int
    let tipo: String
    let dataMovimentacao: String
    let descricao: String
    let categoria: String
    let valor: Double
    let createdAt: String
    let modifiedAt: String
}
