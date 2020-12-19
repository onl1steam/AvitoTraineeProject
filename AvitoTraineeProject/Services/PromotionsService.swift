//
//  PromotionsService.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

protocol PromotionsServiceProtocol {
    
}

final class PromotionsService: PromotionsServiceProtocol {
    
    func fetchPromotions() {
        if let path = Bundle.main.path(forResource: "result", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                parsePromotions(from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func parsePromotions(from jsonData: Data) {
        do {
            let promotionsStatusResponse = try JSONDecoder().decode(PromotionsStatusResponse.self, from: jsonData)
            print(promotionsStatusResponse.result)
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
