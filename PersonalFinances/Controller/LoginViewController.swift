//
//  LoginViewController.swift
//  PersonalFinances
//
//  Created by Ruth Ellen da Silva on 19/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    init() {
        super.init(nibName: "LoginView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnAccess: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func access(_ sender: Any) {
        guard let user = tfUser?.text, !user.isEmpty else {
            alertErro(mensagem: "Usuário não pode estar vazio")
            return
        }
        
        guard let pass = tfPassword?.text, !pass.isEmpty else {
            alertErro(mensagem: "Senha não pode estar vazia")
            return
        }
        
        Rest.login(user, pass) { (response) in
            if response {
                DispatchQueue.main.async {
                    self.loginCorreto()
                }
            } else {
                DispatchQueue.main.async {
                    self.alertErro(mensagem: "Login ou senha incorretos")
                }
            }
        }
    }
    
    func loginCorreto(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let ftb = sb.instantiateViewController(withIdentifier: "main") as! UINavigationController
        ftb.modalPresentationStyle = .fullScreen
        self.present(ftb, animated: true, completion: nil)
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
