//
//  PromotionsCollectionDataSource.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 21.12.2020.
//

import UIKit

final class PromotionsCollectionDataSource: NSObject {
    
    // MARK: - Private Properties
    
    private var promotions = [PromotionViewModel]()
    private let presenter: PromotionsPresenterProtocol
    
    // MARK: - Initializers
    
    init(presenter: PromotionsPresenterProtocol) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - Public methods
    
    func update(with promotionsList: [PromotionViewModel]) {
        self.promotions = promotionsList
    }
}

// MARK: - UICollectionViewDataSource

extension PromotionsCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        promotions.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? PromotionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: promotions[indexPath.row])
        cell.dataTask = presenter.getImage(row: indexPath.row, completion: { data in
            DispatchQueue.global().async {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.setImage(image)
                }
            }
        })
        if let selectedRow = presenter.selectedPromoNumber, indexPath.row == selectedRow {
            cell.changeCheckmarkVisibility(isHidden: false)
        } else {
            cell.changeCheckmarkVisibility(isHidden: true)
        }
        return cell
    }
}
