//
//  ViewController.swift
//  WeatherReport
//
//  Created by MAC205 on 03/03/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var db:DBHelper = DBHelper()
    var users:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users = db.read()
        addDoneButtonOnKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        emailTextField.inputAccessoryView = doneToolbar
        passwordTextField.inputAccessoryView = doneToolbar
    }
    
    @IBAction func signinAction(_ sender : UIButton) {
        if emailTextField.text == "" {
            showAlert(with: "Please enter your emil")
        } else if passwordTextField.text == "" {
            showAlert(with: "Please enter your password")
        } else {
            isUserHadAccount()
        }
    }
    
    func isUserHadAccount() {
        let res = users.filter { $0.email == emailTextField.text}
        if res.count == 0 {
            showAlert(with: "You dont have an account please signup")
        } else {
            if res[0].password != passwordTextField.text {
                showAlert(with: "Please enter correct password")
            } else {//success redirect to list screen
                UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListUsersViewController") as! ListUsersViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func createNewAccountAction(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showAlert(with message: String)
    {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            
        })
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func doneButtonAction(){
        
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
    }
}

