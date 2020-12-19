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
    
    var promotions: [PromotionViewModel] = []
    
    required init(view: PromotionsViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        interactor.getPromotions { [weak self] promotionsInfo in
            guard let self = self else { return }
            switch promotionsInfo {
            case .success(let response):
                self.promotions = self.makePromotionViewModel(from: response.list)
                self.view?.updateCollectionView()
                self.view?.setPromotionInfo(self.makePromotioInfoViewModel(from: response))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func chooseButtonTapped(row: Int) {
        view.showAlert(title: "Выбрана услуга", description: "Выбрана услуга: \(promotions[row].title)")
    }
    
    func getPromotionsCount() -> Int {
        promotions.count
    }
    
    func getPromotion(for row: Int) -> PromotionViewModel {
        promotions[row]
    }
    
    private func makePromotionViewModel(from promotions: [Promotion]) -> [PromotionViewModel] {
        return promotions.map { promotion -> PromotionViewModel in
            return PromotionViewModel(id: promotion.id,
                                      title: promotion.title,
                                      description: promotion.description,
                                      iconUrl: promotion.icon.icon52Url,
                                      price: promotion.price,
                                      isSelected: promotion.isSelected)
        }
    }
    
    private func makePromotioInfoViewModel(from promotionsInfo: PromotionsInfoResponse) -> PromotionInfoViewModel {
        return PromotionInfoViewModel(title: promotionsInfo.title,
                                      actionTitle: promotionsInfo.actionTitle,
                                      selectedActionTitle: promotionsInfo.selectedActionTitle)
    }
}
