//
//  ContactRepositoryProtocol.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation
import Combine

protocol ContactRepositoryProtocol {
    func loadContactsFromFile() -> AnyPublisher<[ContactModel], Error>
}
