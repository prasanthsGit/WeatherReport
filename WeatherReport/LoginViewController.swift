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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signinAction(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListUsersViewController") as! ListUsersViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func createNewAccountAction(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

