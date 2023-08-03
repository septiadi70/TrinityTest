//
//  ListViewModel.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation
import Combine

final class ListViewModel {
    let useCase: ListUseCaseProtocol
    
    @Published var contacts = [ContactModel]()
    @Published var error: Error?
    @Published var isLoading = false
    
    var bags = Set<AnyCancellable>()
    
    init(useCase: ListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loadContacts() {
        isLoading = true
        useCase
            .loadContacts()
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let err):
                    self?.error = err
                case .finished: break
                }
            } receiveValue: { [weak self] contacts in
                self?.isLoading = false
                self?.contacts = contacts
            }
            .store(in: &bags)
    }
    
    func saveContact(_ contact: ContactModel) {
        if let i = contacts.firstIndex(where: { $0.id == contact.id }) {
            contacts[i] = contact
        } else {
            contacts.append(contact)
        }
    }
}
