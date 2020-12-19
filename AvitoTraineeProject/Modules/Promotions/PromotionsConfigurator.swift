//
//  PromotionsConfigurator.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

final class PromotionsConfigurator: PromotionsConfiguratorProtocol {
    
    func configure(with viewController: PromotionsViewController) {
        let presenter = PromotionsPresenter(view: viewController)
        let interactor = PromotionsInteractor(presenter: presenter)
        let router = PromotionsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
