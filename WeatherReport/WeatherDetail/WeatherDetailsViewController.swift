//
//  WeatherDetailsViewController.swift
//  WeatherReport
//
//  Created by MAC205 on 03/03/21.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var weatherList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherList.register(UINib(nibName: "WeatherDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailsTableViewCell")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func backAction(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutAction(_ sender : UIButton) {

        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        // iOS13 or later
        if #available(iOS 13.0, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes
                .first!.delegate as! SceneDelegate
            
            sceneDelegate.window!.rootViewController = initialViewController

        // iOS12 or earlier
        } else {
            // UIApplication.shared.keyWindow?.rootViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window!.rootViewController = initialViewController
        }
        
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        self.navigationController?.popToRootViewController(animated: false)
    }
}

//MARK: UITABLEVIEW DELEGATE/DATASOURCE

extension WeatherDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsTableViewCell", for: indexPath) as? WeatherDetailsTableViewCell
        
        return contentCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row --> \(indexPath.row)")
        
    }
    
}
