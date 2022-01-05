//
//  FinancasTableViewCell.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 29/12/21.
//

import UIKit

class FinancasTableViewCell: UITableViewCell {

    @IBOutlet weak var lbCategoria: UILabel!
    @IBOutlet weak var lbValor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with financa: Financas.FinancaResponse.Get) {
        var categoria: String?
        switch financa.categoria {
        case "SAUDE":
            categoria = "Saúde"
        case "TRANSPORTE":
            categoria = "Transporte"
        case "ALIMENTACAO":
            categoria = "Alimentação"
        case "SALARIO":
            categoria = "Salário"
        case "ALUGUEL":
            categoria = "Aluguel"
        default:
            categoria = "Outros"
        }
        lbCategoria.text = categoria
        lbValor.text = "R$ \(String(format: "%.02f", financa.valor))"
    }
}
