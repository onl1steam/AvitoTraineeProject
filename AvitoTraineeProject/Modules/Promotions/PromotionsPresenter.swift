//
//  PromotionsPresenter.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

final class PromotionsPresenter: PromotionsPresenterProtocol {
    
    weak var view: PromotionsViewProtocol!
    var interactor: PromotionsInteractorProtocol!
    var router: PromotionsRouterProtocol!
    
    required init(view: PromotionsViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        interactor.getPromotions { promotionsInfo in
            switch promotionsInfo {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
