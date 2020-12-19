//
//  PromotionsProtocols.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import UIKit

protocol PromotionsViewProtocol: class {
    func updateCollectionView()
    func setPromotionInfo(_ promotionInfo: PromotionInfoViewModel)
    func showAlert(title: String, description: String)
}

protocol PromotionsPresenterProtocol: class {
    func configureView()
    func chooseButtonTapped(row: Int)
    func getPromotionsCount() -> Int
    func getPromotion(for row: Int) -> PromotionViewModel
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
