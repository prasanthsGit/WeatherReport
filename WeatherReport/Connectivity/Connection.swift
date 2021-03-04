//
//  Connection.swift
//  WeatherReport
//
//  Created by MAC205 on 04/03/21.
//


import UIKit
import Alamofire
import SwiftyJSON

class Connection {
    //MARK: GET METHOD
    func requestGET(_ url: String, params : Parameters?, headers : HTTPHeaders?, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void) {
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("URL = ",encodedUrl)
        print("HEADERS = ",headers ?? [])
        print("Parameters = ",params ?? [])
        
        if Connectivity.isConnectedToInternet() {
            AF.request(encodedUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {
                (response) in
                switch response.result {
                case .success:
                    if let data = response.data {
                        let arr = JSON(data)
                        print("Response = ", arr)
                        success(data)
                    }
                case .failure(let error):
                    print("NETWORK ERROR")
                    failure(error)
                }
            }
        }else {
            print("NO NETWORK")
        }
    }
}

class Connectivity
{
    class func isConnectedToInternet() ->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}
