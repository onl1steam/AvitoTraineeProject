//
//  PromotionsInteractor.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import Foundation

final class PromotionsInteractor {
    
    // MARK: - Public Properties
    
    weak var presenter: PromotionsPresenterProtocol!
    let promotionsService: PromotionsServiceProtocol
    let imageService: ImageServiceProtocol
    
    // MARK: - Initializers
    
    required init(presenter: PromotionsPresenterProtocol,
                  promotionsService: PromotionsServiceProtocol = PromotionsService(),
                  imageService: ImageServiceProtocol = ImageService()) {
        self.presenter = presenter
        self.promotionsService = promotionsService
        self.imageService = imageService
    }
}

// MARK: - PromotionsInteractorProtocol

extension PromotionsInteractor: PromotionsInteractorProtocol {
    
    func getPromotions(completion: @escaping (Result<PromotionsInfoResponse,Error>) -> Void) {
        promotionsService.fetchPromotions(completion: completion)
    }
    
    func getImageData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        imageService.fetchImage(urlString: urlString, completion: completion)
    }
}
