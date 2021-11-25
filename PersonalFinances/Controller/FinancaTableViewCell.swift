//
//  FinancaTableViewCell.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 18/11/21.
//

import UIKit

class FinancaTableViewCell: UITableViewCell {

    @IBOutlet weak var lbCategoria: UILabel!
    @IBOutlet weak var lbValor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepare(with financa: FinancaBack) {
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
