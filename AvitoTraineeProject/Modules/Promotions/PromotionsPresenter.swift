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
    
    var promotionInfo: PromotionInfoViewModel?
    var promotions: [PromotionViewModel] = []
    var selectedPromoNumber: Int?
    
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
                let promoInfo = self.makePromotioInfoViewModel(from: response)
                self.promotionInfo = promoInfo
                self.view?.setPromotionInfo(promoInfo)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func cellTapped(row: Int?) {
        guard let promInfo = promotionInfo else { return }
        guard let number = row else {
            selectedPromoNumber = nil
            view.changeButtonTitle(promInfo.actionTitle)
            return
        }
        view.changeButtonTitle(promInfo.selectedActionTitle)
        selectedPromoNumber = number
    }
    
    func chooseButtonTapped() {
        guard let number = selectedPromoNumber else {
            view.showAlert(title: "Выбор услуги", description: "Ни одна услуга не выбрана.")
            return
        }
        view.showAlert(title: "Выбор услуги", description: "Выбрана услуга: \(promotions[number].title).")
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
                                      price: promotion.price)
        }
    }
    
    private func makePromotioInfoViewModel(from promotionsInfo: PromotionsInfoResponse) -> PromotionInfoViewModel {
        return PromotionInfoViewModel(title: promotionsInfo.title,
                                      actionTitle: promotionsInfo.actionTitle,
                                      selectedActionTitle: promotionsInfo.selectedActionTitle)
    }
}
