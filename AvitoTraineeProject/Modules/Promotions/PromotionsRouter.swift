//
//  PromotionsRouter.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

final class PromotionsRouter: PromotionsRouterProtocol {
    weak var viewController: PromotionsViewController!
    
    init(viewController: PromotionsViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
