//
//  PromoCollectionViewCell.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 20.12.2020.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var promotionImageView: UIImageView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var dataTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
    }
    
    func setImage(_ image: UIImage?) {
        promotionImageView.image = image
    }
    
    func configureCell(with promotion: PromotionViewModel) {
        titleLabel.text = promotion.title
        priceLabel.text = promotion.price
        guard let descriptionText = promotion.description else {
            descriptionLabel.isHidden = true
            return
        }
        descriptionLabel.isHidden = false
        descriptionLabel.text = descriptionText
    }
    
    func changeCheckmarkVisibility(isHidden: Bool) {
        checkmarkImageView.isHidden = isHidden
    }
}
