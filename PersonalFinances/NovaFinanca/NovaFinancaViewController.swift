//
//  NovaFinancaViewController.swift
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

protocol NovaFinancaDisplayLogic: class
{
    func redirect()
    func erro()
    func displayDateLimit(date: Date)
}

class NovaFinancaViewController: UIViewController, NovaFinancaDisplayLogic {
    
    var interactor: NovaFinancaBusinessLogic?
    var router: (NSObjectProtocol & NovaFinancaRoutingLogic)?
    
    weak var delegate: NovaFinancaDelegate?

    // MARK: Object lifecycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup Clean Code Design Pattern 

    private func setup() {
        let viewController = self
        let interactor = NovaFinancaInteractor()
        let presenter = NovaFinancaPresenter()
        let router = NovaFinancaRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }

    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        aditionalSetup()
    }
    
    //MARK: - receive events from UI
    
    @IBOutlet weak var scTipo: UISegmentedControl!
    @IBOutlet weak var dpDataMovimentacao: UIDatePicker!
    @IBOutlet weak var tfDescricao: UITextField!
    @IBOutlet weak var pvCategoria: UIPickerView!
    @IBOutlet weak var tfValor: UITextField!
    
    @IBAction func addFinanca(_ sender: Any) {
        novaFinanca()
    }
    
    // MARK: - request data from NovaFinancaInteractor

    func novaFinanca() {
        guard let descricao = tfDescricao.text, !descricao.isEmpty else {
            erro()
            return
        }
        
        guard let valor = tfValor.text, !valor.isEmpty else {
            erro()
            return
        }
        
        var tipo: Tipo
        switch scTipo.selectedSegmentIndex {
        case 0:
            tipo = .RECEITA
        case 1:
            tipo = .DESPESA
        default:
            erro()
            return
        }
        
        let categoria = Categoria.allCases[pvCategoria.selectedRow(inComponent: 0)]
        
        var categoriaString: String
        switch categoria {
        case .SAUDE:
            categoriaString = "SAUDE"
        case .ALIMENTACAO:
            categoriaString = "ALIMENTACAO"
        case .ALUGUEL:
            categoriaString = "ALUGUEL"
        case .OUTROS:
            categoriaString = "OUTROS"
        case .SALARIO:
            categoriaString = "SALARIO"
        case .TRANSPORTE:
            categoriaString = "TRANSPORTE"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = formatter.string(from: dpDataMovimentacao.date)
        
        interactor?.handleFetchNewFinance(request: .init(idUser: 1, tipo: tipo.rawValue, dataMovimentacao: date, descricao: descricao, categoria: categoriaString, valor: Double(valor)!))
    }
    
    func aditionalSetup() {
        interactor?.handleDataLimit()
    }
    

    // MARK: - display view model from NovaFinancaPresenter

    func redirect() {
        DispatchQueue.main.async {
            self.delegate?.addFinance()
            self.router?.routeBackToFinances()
        }
    }
    
    func erro() {
        DispatchQueue.main.async {
            self.alertErro(mensagem: "Erro ao adicionar financa")
        }
    }
    
    func displayDateLimit(date: Date) {
        dpDataMovimentacao.maximumDate = date
    }
    
    func alertErro(mensagem: String) {
        let alert = UIAlertController(title: "Erro", message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("")
          })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
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