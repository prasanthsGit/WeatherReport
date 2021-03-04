//
//  User.swift
//  WeatherReport
//
//  Created by MAC205 on 04/03/21.
//

import Foundation

class User
{
    var id: Int = 0
    var email: String = ""
    var firstName: String = ""
    var lastName : String = ""
    var password : String = ""
    
    
    init(id:Int, email:String, firstName:String,lastName:String, password:String)
    {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
    
}

class WeatherModel : Codable {
    var daily : [WeatherData]
}

class WeatherData : Codable {
    var temp : tempModel?
    var weatherType: [WeatherDetails]
    var humidity: Double?
    var windSpeed: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case weatherType = "weather"
        case windSpeed = "wind_speed"
        case humidity
    }
}

class tempModel: Codable {
    var min: Double?
    var max: Double?
}

class WeatherDetails: Codable {
    var main: String?
    var description: String?
}

