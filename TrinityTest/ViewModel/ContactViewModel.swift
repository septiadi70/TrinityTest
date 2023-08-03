//
//  ContactViewModel.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation

final class ContactViewModel {
    let contact: ContactModel
    
    init(contact: ContactModel) {
        self.contact = contact
    }
    
    var name: String {
        contact.firstName + " " + contact.lastName
    }
}
