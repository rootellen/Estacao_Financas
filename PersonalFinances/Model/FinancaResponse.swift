//
//  FinancaResponse.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 23/11/21.
//

import Foundation

struct FinancaResponse: Codable {
    let idUser: Int
    let totalExpense: Double
    let totalIncome: Double
    let financialIncomeResponseList: [FinancaBack]
    let financialExpensesResponseList: [FinancaBack]
}
