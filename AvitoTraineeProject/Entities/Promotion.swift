//
//  Promotion.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

struct Promotion: Codable {
    var id: String
    var title: String
    var description: String?
    var icon: PromotionIcon
    var price: String
    var isSelected: Bool
}

struct PromotionIcon: Codable {
    var icon52Url: String
    
    private enum CodingKeys : String, CodingKey {
        case icon52Url = "52x52"
    }
}
