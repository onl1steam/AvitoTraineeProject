//
//  PromotionsService.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

/// Сервис парсинга услуг по продвижению объявления
protocol PromotionsServiceProtocol: class {
    func fetchPromotions(completion: @escaping (Result<PromotionsInfoResponse,Error>) -> Void)
}

final class PromotionsService: PromotionsServiceProtocol {
    
    // MARK: - PromotionsServiceProtocol Realization
    
    func fetchPromotions(completion: @escaping (Result<PromotionsInfoResponse,Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "result", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                parsePromotions(from: data, completion: completion)
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func parsePromotions(from jsonData: Data,
                                 completion: @escaping (Result<PromotionsInfoResponse,Error>) -> Void) {
        do {
            let promotionsStatusResponse = try JSONDecoder().decode(PromotionsStatusResponse.self, from: jsonData)
            let result = promotionsStatusResponse.result
            completion(.success(result))
        } catch let error {
            completion(.failure(error))
        }
    }
    
}
