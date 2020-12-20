//
//  PromotionsInteractor.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

final class PromotionsInteractor: PromotionsInteractorProtocol {
    
    weak var presenter: PromotionsPresenterProtocol!
    let promotionsService: PromotionsServiceProtocol
    let imageService: ImageServiceProtocol
    
    required init(presenter: PromotionsPresenterProtocol,
                  promotionsService: PromotionsServiceProtocol = PromotionsService(),
                  imageService: ImageServiceProtocol = ImageService()) {
        self.presenter = presenter
        self.promotionsService = promotionsService
        self.imageService = imageService
    }
    
    func getPromotions(completion: @escaping (Result<PromotionsInfoResponse,Error>) -> Void) {
        promotionsService.fetchPromotions(completion: completion)
    }
    
    func getImageData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        imageService.fetchImage(urlString: urlString, completion: completion)
    }
}
