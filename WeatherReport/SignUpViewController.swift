//
//  SignUpViewController.swift
//  WeatherReport
//
//  Created by MAC205 on 03/03/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emilTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var passwordextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var checkBoxBtn : UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var activeField: UITextField?
    
    var db:DBHelper = DBHelper()
    
    var users:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        checkBoxBtn.isSelected = false
        users = db.read()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        firstNameTextField.inputAccessoryView = doneToolbar
        lastNameTextField.inputAccessoryView = doneToolbar
        emilTextField.inputAccessoryView = doneToolbar
        genderTextField.inputAccessoryView = doneToolbar
        passwordextField.inputAccessoryView = doneToolbar
        confirmPasswordTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        scrollView.isScrollEnabled = true
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if activeField != nil
        {
            if (!aRect.contains(activeField!.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardSize!.height, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    @objc func doneButtonAction(){
                
        if firstNameTextField.isFirstResponder {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        } else if lastNameTextField.isFirstResponder {
            lastNameTextField.resignFirstResponder()
            emilTextField.becomeFirstResponder()
        } else if emilTextField.isFirstResponder {
            emilTextField.resignFirstResponder()
            genderTextField.becomeFirstResponder()
        } else if genderTextField.isFirstResponder {
            genderTextField.resignFirstResponder()
            passwordextField.becomeFirstResponder()
        } else if passwordextField.isFirstResponder {
            passwordextField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        } else if confirmPasswordTextField.isFirstResponder {
            confirmPasswordTextField.resignFirstResponder()
            
        } else {
            
        }
    }
    
    @IBAction func signUpAction(_ sender : UIButton) {
        
        if firstNameTextField.text == "" {
            showAlert(with: "Please enter your first name")
        } else if lastNameTextField.text == ""  {
            showAlert(with: "Please enter your last name")
        } else if emilTextField.text == ""  {
            showAlert(with: "Please enter your emil")
        } else if passwordextField.text == ""  {
            showAlert(with: "Please enter your password")
        } else if confirmPasswordTextField.text == ""  {
            showAlert(with: "Please confirm password")
        } else {//mantatory field filled
            if passwordextField.text !=  confirmPasswordTextField.text {
                showAlert(with: "Your password and confirm password mismatched")
            } else if !checkBoxBtn.isSelected {
                showAlert(with: "Kindly accept the terms & conditions")
            } else {
                if let getLatestId = UserDefaults.standard.value(forKey: "UserId") as? Int {
                    UserDefaults.standard.setValue(getLatestId + 1 , forKey: "UserId")
                } else {
                    UserDefaults.standard.setValue(1, forKey: "UserId")
                }
                
                let userMail = users.filter { $0.email == emilTextField.text}
                
                if userMail.count > 0 {//mail already registered
                    showAlert(with: "Sorry, this mail already registered")
                } else {
                    db.insert(id: UserDefaults.standard.value(forKey: "UserId") as? Int ?? 1, email: emilTextField.text ?? "", firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", password: passwordextField.text ?? "")
                    UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListUsersViewController") as! ListUsersViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            
        }
        
    }
    
    @IBAction func showAlert(with message: String)
    {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle:UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
       { action -> Void in
         
       })
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func backAction(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkBoxAction(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        checkBoxImageView.image = UIImage(named: sender.isSelected ? "checkBoxSel" : "checkBoxUnSel")
    }

}
