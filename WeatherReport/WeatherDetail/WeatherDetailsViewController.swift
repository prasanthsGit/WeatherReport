//
//  WeatherDetailsViewController.swift
//  WeatherReport
//
//  Created by MAC205 on 03/03/21.
//

import UIKit
import Alamofire

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var weatherList: UITableView!
    
    var weatherDetail : [WeatherData]?
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherList.register(UINib(nibName: "WeatherDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherDetailsTableViewCell")
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        getweatherReport()
    }
    
    func getweatherReport() {
        let connection = Connection()
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=12.9082847623315&lon=77.65197822993314&units=imperial&appid=b143bb707b2ee117e62649b358207d3e"
        
        let headers : HTTPHeaders = [
            "Authorization" : ""
        ]
        
        connection.requestGET(url, params: nil, headers: headers, success:
                                {(result) in
                                    do {
                                        let data = try JSONDecoder().decode(WeatherModel.self, from: result)
                                        self.weatherDetail = data.daily
                                        print("count --> \(self.weatherDetail?.count ?? 0)")
                                        self.weatherList.reloadData()
                                    }catch let DecodingError.dataCorrupted(context) {
                                        print(context)
                                    } catch let DecodingError.keyNotFound(key, context) {
                                        print("Key '\(key)' not found:", context.debugDescription)
                                        print("codingPath:", context.codingPath)
                                    } catch let DecodingError.valueNotFound(value, context) {
                                        print("Value '\(value)' not found:", context.debugDescription)
                                        print("codingPath:", context.codingPath)
                                    } catch let DecodingError.typeMismatch(type, context)  {
                                        print("Type '\(type)' mismatch:", context.debugDescription)
                                        print("codingPath:", context.codingPath)
                                    } catch let error{
                                        print("error: ", error.localizedDescription)
                                    }
                                }, failure: {(error) in
                                    print(error)
                                })
        
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
        return self.weatherDetail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailsTableViewCell", for: indexPath) as? WeatherDetailsTableViewCell
        contentCell?.tempLabel.text = "\(self.weatherDetail?[indexPath.row].temp?.min ?? 0.0)"
        contentCell?.weatherTypeLabel.text = "\(self.weatherDetail?[indexPath.row].weatherType[0].main ?? "")"
        contentCell?.humidityLabel.text = "\(self.weatherDetail?[indexPath.row].humidity ?? 0.0)"
        contentCell?.windSpeedLabel.text = "\(self.weatherDetail?[indexPath.row].windSpeed ?? 0.0)"
        
        return contentCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row --> \(indexPath.row)")
        
    }
    
}
