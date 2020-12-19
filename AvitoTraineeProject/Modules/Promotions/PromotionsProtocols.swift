//
//  PromotionsProtocols.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import UIKit

protocol PromotionsViewProtocol: class {
    
}

protocol PromotionsPresenterProtocol: class {
    func configureView()
}

protocol PromotionsInteractorProtocol: class {
    func getPromotions(completion: @escaping (Result<PromotionsInfoResponse,Error>) -> Void)
}

protocol PromotionsRouterProtocol: class {
    func closeCurrentViewController()
}

protocol PromotionsConfiguratorProtocol: class {
    func configure(with viewController: PromotionsViewController)
}
