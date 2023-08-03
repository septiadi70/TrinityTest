//
//  Injection.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation

struct Injection {
    static func provideContactRepository() -> ContactRepositoryProtocol {
        let fileService = FileService()
        return ContactRepository(fileService: fileService)
    }
}

