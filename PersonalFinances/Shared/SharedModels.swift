//
//  SharedModels.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 28/12/21.
//

import Foundation

enum Tipo: String {
    case DESPESA = "DESPESA"
    case RECEITA = "RECEITA"
}

enum Categoria: String, CaseIterable {
    case SAUDE = "Saúde"
    case TRANSPORTE = "Transporte"
    case ALIMENTACAO = "Alimentação"
    case SALARIO = "Salário"
    case ALUGUEL = "Aluguel"
    case OUTROS = "Outros"
}
