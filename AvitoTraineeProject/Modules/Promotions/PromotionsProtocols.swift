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
    func changeButtonTitle(_ title: String)
}

protocol PromotionsPresenterProtocol: class {
    var selectedPromoNumber: Int? { get }
    func configureView()
    func chooseButtonTapped()
    func cellTapped(row: Int?)
    func getPromotionsCount() -> Int
    func getPromotion(for row: Int) -> PromotionViewModel
    func getImage(row: Int, completion: @escaping (Data) -> Void) -> URLSessionDataTask?
}

protocol PromotionsInteractorProtocol: class {
    func getPromotions(completion: @escaping (Result<PromotionsInfoResponse,Error>) -> Void)
    func getImageData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask?
}

protocol PromotionsRouterProtocol: class {
    func closeCurrentViewController()
}

protocol PromotionsConfiguratorProtocol: class {
    func configure(with viewController: PromotionsViewController)
}
