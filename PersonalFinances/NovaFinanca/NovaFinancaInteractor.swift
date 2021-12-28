//
//  NovaFinancaInteractor.swift
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

protocol NovaFinancaBusinessLogic {
    func handleFetchNewFinance(request: NovaFinanca.Financa.Request)
    
    func handleDataLimit()
}

class NovaFinancaInteractor: NovaFinancaBusinessLogic {
    
    var presenter: NovaFinancaPresentationLogic?
    var worker: NovaFinancaWorker?

    // MARK: Do something (and send response to NovaFinancaPresenter)
    
    func handleFetchNewFinance(request: NovaFinanca.Financa.Request) {
        worker = NovaFinancaWorker()
        worker?.postFinance(financa: request, completion: { (response) in
            self.presenter?.presentResult(response: response)
        })
    }
    
    func handleDataLimit() {
        let date = Date()
        presenter?.presentDataLimit(date: date)
    }

}
