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
}
