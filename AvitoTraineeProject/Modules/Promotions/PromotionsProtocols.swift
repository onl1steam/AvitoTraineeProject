//
//  PromotionsProtocols.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import UIKit

protocol PromotionsViewProtocol: class {
    func updateCollectionView(with promotionList: [PromotionViewModel])
    func setPromotionInfo(_ promotionInfo: PromotionInfoViewModel)
    func changeButtonTitle(_ title: String)
    func showAlert(title: String, description: String)
}

protocol PromotionsPresenterProtocol: class {
    var selectedPromoNumber: Int? { get }
    
    func configureView()
    func chooseButtonTapped()
    func closeButtonTapped()
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
