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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpAction(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListUsersViewController") as! ListUsersViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backAction(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkBoxAction(_ sender : UIButton) {
        
    }

}
