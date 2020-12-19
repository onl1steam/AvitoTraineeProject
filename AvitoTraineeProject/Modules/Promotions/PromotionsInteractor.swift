//
//  PromotionsInteractor.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

final class PromotionsInteractor: PromotionsInteractorProtocol {
    
    weak var presenter: PromotionsPresenterProtocol!
    let promotionsService: PromotionsServiceProtocol
    
    required init(presenter: PromotionsPresenterProtocol, promotionsService: PromotionsServiceProtocol = PromotionsService()) {
        self.presenter = presenter
        self.promotionsService = promotionsService
    }
}
