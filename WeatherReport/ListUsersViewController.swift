//
//  ListUsersViewController.swift
//  WeatherReport
//
//  Created by MAC205 on 03/03/21.
//

import UIKit

class ListUsersViewController: UIViewController {

    @IBOutlet weak var userListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        
    }

}

//MARK: UITABLEVIEW DELEGATE/DATASOURCE

extension ListUsersViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell
        
        return contentCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row --> \(indexPath.row)")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as! WeatherDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
