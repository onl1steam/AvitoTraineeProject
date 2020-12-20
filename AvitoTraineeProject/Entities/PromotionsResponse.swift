//
//  PromotionsResponse.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

struct PromotionsStatusResponse: Codable {
    var status: String
    var result: PromotionsInfoResponse
}

struct PromotionsInfoResponse: Codable {
    var title: String
    var actionTitle: String
    var selectedActionTitle: String
    var list: [Promotion]
}
