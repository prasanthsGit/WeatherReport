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
