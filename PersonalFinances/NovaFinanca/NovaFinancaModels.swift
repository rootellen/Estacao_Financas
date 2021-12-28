//
//  NovaFinancaModels.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 27/12/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum NovaFinanca
{
    // MARK: Use cases

    enum Financa
    {
        struct Request: Codable
        {
            let idUser: Int
            let tipo: String
            let dataMovimentacao: String
            let descricao: String
            let categoria: String
            let valor: Double
        }

        struct Response
        {
            let response: Bool
        }
    }
}