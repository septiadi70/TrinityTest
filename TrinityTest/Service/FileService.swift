//
//  FileService.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import Foundation

final class FileService {
    func arrayObjectFromFromJSONFile<T: Decodable>(
        fileName file: String,
        type: T.Type,
        result: @escaping ((Result<T, Error>) -> Void)
    ) {
        guard let path = Bundle.main.path(forResource: file, ofType: "json")
        else {
//            result(.failure(AppError.fileNotFound))
            // TODO: Handle error
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let array = try decoder.decode(type.self, from: data)
            result(.success(array))
        } catch {
            result(.failure(error))
        }
    }
}
