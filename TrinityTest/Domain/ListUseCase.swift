//
//  ListUseCase.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation
import Combine

final class ListUseCase: ListUseCaseProtocol {
    let repository: ContactRepositoryProtocol
    
    init(repository: ContactRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadContacts() -> AnyPublisher<[ContactModel], Error> {
        repository.loadContactsFromFile()
    }
}
