//
//  NovaFinancaViewController.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 18/11/21.
//

import UIKit

class NovaFinancaViewController: UIViewController {
    
    @IBOutlet weak var scTipo: UISegmentedControl!
    @IBOutlet weak var dpDataMovimentacao: UIDatePicker!
    @IBOutlet weak var tfDescricao: UITextField!
    @IBOutlet weak var pvCategoria: UIPickerView!
    @IBOutlet weak var tfValor: UITextField!
    
    var delegate: FinancaTableViewController?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpDataMovimentacao.maximumDate = Date()
    }

    @IBAction func addFinanca(_ sender: Any) {

        guard let descricao = tfDescricao.text, !descricao.isEmpty else {
            return
        }
        
        guard let valor = tfValor.text, !valor.isEmpty else {
            return
        }
        
        var tipo: Tipo
        switch scTipo.selectedSegmentIndex {
        case 0:
            tipo = .RECEITA
        default:
            tipo = .DESPESA
        }
        let categoria = Categoria.allCases[pvCategoria.selectedRow(inComponent: 0)]
        
        var categoriaString: String
        switch categoria {
        case .ALIMENTACAO:
            categoriaString = "ALIMENTACAO"
        case .ALUGUEL:
            categoriaString = "ALUGUEL"
        case .OUTROS:
            categoriaString = "OUTROS"
        case .SALARIO:
            categoriaString = "SALARIO"
        default:
            categoriaString = "TRANSPORTE"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = formatter.string(from: dpDataMovimentacao.date)
                
        let financa = Financa(id: id!, idUser: 1, tipo: tipo.rawValue, dataMovimentacao: date, descricao: descricao, categoria: categoriaString, valor: Double(valor)!)
        
        Rest.addFinance(finance: financa) { (success) in
            DispatchQueue.main.async {
                self.delegate?.addFinanca(financa)
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
}

extension NovaFinancaViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Categoria.allCases[row].rawValue
    }
}


extension NovaFinancaViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Categoria.allCases.count
    }
    
    
}
