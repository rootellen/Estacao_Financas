//
//  FinancaTableViewController.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 18/11/21.
//

import UIKit

protocol FinancaTableViewControllerDelegate {
    func addFinanca(_ financa: Financa)

}

class FinancaTableViewController: UITableViewController, FinancaTableViewControllerDelegate {
    
    @IBOutlet weak var lbSaldo: UILabel!
    @IBOutlet weak var scFiltro: UISegmentedControl!
    @IBOutlet weak var lbReceitas: UILabel!
    @IBOutlet weak var lbDespesas: UILabel!

    var financas: [FinancaBack] = []
    var totalReceitas: Double = 0
    var totalDespesas: Double = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        atualizarValores()
    }
    
    func reloadData() {
        Rest.loadFinances { (finances) in
            self.financas.removeAll()
            self.financas.append(contentsOf: finances.financialExpensesResponseList)
            self.financas.append(contentsOf: finances.financialIncomeResponseList)
            self.totalReceitas = finances.totalIncome
            self.totalDespesas = finances.totalExpense
            //para executar apenas na main thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.atualizarValores()
            }
        } onError: { (error) in
            print(error)
        }
    }
    
    @IBAction func changeFilter(_ sender: Any) {
        tableView.reloadData()
    }
    
    func addFinanca(_ financa: Financa) {
        reloadData()
        tableView.reloadData()
        atualizarValores()
    }
    
    func atualizarValores(){
        let totalReceitas = self.totalReceitas
        let totalDespesas = self.totalDespesas
        let saldo = totalReceitas - totalDespesas
        lbSaldo.text = "R$ \(String(format: "%.02f", saldo))"
        lbReceitas.text = "R$ \(String(format: "%.02f", totalReceitas))"
        lbDespesas.text = "R$ \(String(format: "%.02f", totalDespesas))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "novaFinanca" {
            let view = segue.destination as! NovaFinancaViewController
            view.delegate = self
            view.id = financas.count + 1
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scFiltro.selectedSegmentIndex == 0 {
            let filter = financas.filter( {$0.tipo == Tipo.RECEITA.rawValue} )
            return filter.count
        } else {
            let filter = financas.filter( {$0.tipo == Tipo.DESPESA.rawValue} )
            return filter.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FinancaTableViewCell
        
        var filter: [FinancaBack] = []
        if scFiltro.selectedSegmentIndex == 0 {
            filter = financas.filter( {$0.tipo == Tipo.RECEITA.rawValue} )
        } else {
            filter = financas.filter( {$0.tipo == Tipo.DESPESA.rawValue} )
        }
        
        let financa = filter[indexPath.row]
        cell.prepare(with: financa)

        return cell
    }
    

}
