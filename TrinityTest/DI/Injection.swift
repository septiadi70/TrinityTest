//
//  Injection.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation

struct Injection {
    private static func provideContactRepository() -> ContactRepositoryProtocol {
        let fileService = FileService()
        return ContactRepository(fileService: fileService)
    }
    
    private static func provideListUseCaseProtocol() -> ListUseCaseProtocol {
        ListUseCase(repository: provideContactRepository())
    }
    
    static func provideListViewModel() -> ListViewModel {
        ListViewModel(useCase: provideListUseCaseProtocol())
    }
    
    static func provideListViewController() -> ListViewController {
        return ListViewController(viewModel: provideListViewModel())
    }
}

