//
//  ContactModel.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation

struct ContactModel: Decodable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String?
    var dob: String?
    
    init(id: String, firstName: String, lastName: String, email: String? = nil, dob: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.dob = dob
    }
    
    init() {
        id = ""
        firstName = ""
        lastName = ""
        email = nil
        dob = nil
    }
}
