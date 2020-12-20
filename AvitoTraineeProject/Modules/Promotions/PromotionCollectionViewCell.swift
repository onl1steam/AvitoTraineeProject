//
//  PromotionCollectionViewCell.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import UIKit

final class PromotionCollectionViewCell: UICollectionViewCell {
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let promotionImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkmark")
        imageView.isHidden = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "XL-объявление"
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Пользователи смогут посмотреть фотографии, описание и телефон прямо из результатов поиска."
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "356 ₽"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundPosition()
        setupPromotionImageViewPosition()
        setupCheckmarkImageViewPosition()
        setupTitleLabelPosition()
        setupDescriptionLabelPosition()
        setupPriceLabelPosition()
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with promotion: PromotionViewModel) {
        titleLabel.text = promotion.title
        priceLabel.text = promotion.price
        guard let descriptionText = promotion.description else {
            descriptionLabel.isHidden = true
            return
        }
        descriptionLabel.text = descriptionText
    }
    
    func changeCheckmarkVisibility(isHidden: Bool) {
        checkmarkImageView.isHidden = isHidden
    }
    
    private func setupBackgroundPosition() {
        addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        let width = UIScreen.main.bounds.width - layoutMargins.left * 2
        NSLayoutConstraint.activate([
            background.widthAnchor.constraint(equalToConstant: width),
            background.topAnchor.constraint(equalTo: topAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
    }
    
    private func setupPromotionImageViewPosition() {
        addSubview(promotionImageView)
        promotionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promotionImageView.heightAnchor.constraint(equalToConstant: 52),
            promotionImageView.widthAnchor.constraint(equalToConstant: 52),
            promotionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layoutMargins.left),
            promotionImageView.topAnchor.constraint(equalTo: topAnchor, constant: layoutMargins.top)
        ])
    }
    
    private func setupCheckmarkImageViewPosition() {
        addSubview(checkmarkImageView)
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: layoutMargins.right),
            checkmarkImageView.centerXAnchor.constraint(equalTo: promotionImageView.centerXAnchor)
        ])
    }
    
    private func setupTitleLabelPosition() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: promotionImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: checkmarkImageView.leadingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: layoutMargins.top)
        ])
    }
    
    private func setupDescriptionLabelPosition() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func setupPriceLabelPosition() {
        addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
    }
    
}
