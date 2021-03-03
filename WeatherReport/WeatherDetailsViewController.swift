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
    }
    
    @IBAction func backAction(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logoutAction(_ sender : UIButton) {
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
