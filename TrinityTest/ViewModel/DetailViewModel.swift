//
//  DetailViewModel.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation

final class DetailViewModel {
    @Published var contact: ContactModel?
    
    init(contact: ContactModel?) {
        self.contact = contact
    }
    
    func save(firstName: String, lastName: String, email: String?, birth: String?) {
        if contact == nil { contact = ContactModel() }
        contact?.firstName = firstName
        contact?.lastName = lastName
        contact?.email = email
        contact?.dob = birth
    }
}
