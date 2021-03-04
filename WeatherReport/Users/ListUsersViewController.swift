//
//  ListUsersViewController.swift
//  WeatherReport
//
//  Created by MAC205 on 03/03/21.
//

import UIKit

class ListUsersViewController: UIViewController {

    @IBOutlet weak var userListTableView: UITableView!
    
    var db:DBHelper = DBHelper()
    
    var users:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userListTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        userListTableView.separatorStyle = .none
        getDbData()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func getDbData() {
        users = db.read()
        if users.count == 0 {
            UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
            self.navigationController?.popToRootViewController(animated: false)
        } else {
            userListTableView.reloadData()
            print("USERS COUNT --> \(users.count)")
        }
        
    }

}

//MARK: UITABLEVIEW DELEGATE/DATASOURCE

extension ListUsersViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell
        
        contentCell?.frstNameLabel.text = users[indexPath.row].firstName
        contentCell?.mailIdLabel.text = users[indexPath.row].email
        contentCell?.contentView.backgroundColor = .clear
        contentCell?.selectionStyle = .none
        return contentCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row --> \(indexPath.row)")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as! WeatherDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("editing style called")
        if (editingStyle == .delete) {
            if (editingStyle == UITableViewCell.EditingStyle.delete) {
                if users.count > 0 {
                    db.deleteByID(id: users[indexPath.row].id)
                    getDbData()
                }
            }
        }
    }
}
