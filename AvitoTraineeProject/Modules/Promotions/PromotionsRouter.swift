//
//  PromotionsRouter.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

final class PromotionsRouter {
    
    // MARK: - Public Properties

    weak var viewController: PromotionsViewController!
    
    // MARK: - Initializers
    
    init(viewController: PromotionsViewController) {
        self.viewController = viewController
    }
}

// MARK: - PromotionsRouterProtocol

extension PromotionsRouter: PromotionsRouterProtocol {
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}


