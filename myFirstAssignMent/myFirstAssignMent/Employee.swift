//
//  Employee.swift
//  myFirstAssignMent
//
//  Created by Areum on 2016-11-25.
//  Copyright © 2016 Areum. All rights reserved.
//

import Foundation

class Employee {
    
    var empName : String = ""
    var empDateOfBirth : String = ""
    var empCountry : String = ""
    
    func setName(pName: String) {
        self.empName = pName
    }
    
    func setDateOfBirth(pDateOfBirth: String) {
        self.empDateOfBirth = pDateOfBirth
    }
    
    func setCountry(pCountry: String) {
        self.empCountry = pCountry
    }
    
    func getName() -> String {
        return self.empName
    }
    
    func getDateOfBirth() -> String {
        return self.empDateOfBirth
    }
    
    func getCountry() -> String {
        return self.empCountry
    }
    
    
    init() {
        empName = ""
        empDateOfBirth = ""
        empCountry = ""
    }
    
    init(pName: String, pDateOfBirth: String, pCountry: String) {
        self.empName = pName
        self.empDateOfBirth = pDateOfBirth
        self.empCountry = pCountry
    }
    
    

    
}
