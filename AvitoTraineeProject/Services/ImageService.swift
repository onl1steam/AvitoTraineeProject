//
//  ImageService.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 20.12.2020.
//

import Foundation

/// Сервис загрузки изображений по ссылке
protocol ImageServiceProtocol: class {
    func fetchImage(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask?
}

final class ImageService: ImageServiceProtocol {
    
    // MARK: - Public properties
    
    let session = URLSession(configuration: .ephemeral)
    var dataTask: URLSessionDataTask?
    
    // MARK: - ImageServiceProtocol Realization
    
    func fetchImage(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else { return nil }
        dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        }
        dataTask?.resume()
        return dataTask
    }
    
}
