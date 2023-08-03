//
//  ContactRepository.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation
import Combine

final class ContactRepository: ContactRepositoryProtocol {
    let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func loadContactsFromFile() -> AnyPublisher<[ContactModel], Error> {
        return Future<[ContactModel], Error> { [weak self] completion in
            self?.fileService.arrayObjectFromFromJSONFile(fileName: "data",
                                                          type: [ContactModel].self) { result in
                switch result {
                case .success(let contacts): completion(.success(contacts))
                case .failure(let error): completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
