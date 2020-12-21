//
//  PromotionCollectionViewCell.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import UIKit

final class PromotionCollectionViewCell: UICollectionViewCell, CollectionViewReusableCell {
    
    private enum CellConstraints {
        static let promotionImageView: CGFloat = 52
        static let checkmarkImageView: CGFloat = 24
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
    }
    
    var dataTask: URLSessionDataTask?
    
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
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellView()
        addCellSubviews()
        setupCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        descriptionLabel.text = promotion.description
    }
    
    func changeCheckmarkVisibility(isHidden: Bool) {
        checkmarkImageView.isHidden = isHidden
    }
    
    private func setupCellView() {
        layer.cornerRadius = 8
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    }
    
    private func addCellSubviews() {
        contentView.addSubview(promotionImageView)
        contentView.addSubview(checkmarkImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func setupCellConstraints() {
        setupPromotionImageViewPosition()
        setupCheckmarkImageViewPosition()
        setupTitleLabelPosition()
        setupDescriptionLabelPosition()
        setupPriceLabelPosition()
    }
    
    private func setupPromotionImageViewPosition() {
        promotionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promotionImageView.heightAnchor.constraint(equalToConstant: CellConstraints.promotionImageView),
            promotionImageView.widthAnchor.constraint(equalToConstant: CellConstraints.promotionImageView),
            promotionImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            promotionImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor)
        ])
    }
    
    private func setupTitleLabelPosition() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelWidth = CellConstraints.screenWidth
            - CellConstraints.promotionImageView
            - CellConstraints.checkmarkImageView
            - contentView.layoutMargins.left * 2 - 60
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth),
            titleLabel.leadingAnchor.constraint(equalTo: promotionImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: checkmarkImageView.leadingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor)
        ])
    }
    
    private func setupCheckmarkImageViewPosition() {
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkmarkImageView.heightAnchor.constraint(equalToConstant: CellConstraints.checkmarkImageView),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: CellConstraints.checkmarkImageView),
            checkmarkImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 26)
        ])
    }
    
    private func setupDescriptionLabelPosition() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func setupPriceLabelPosition() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
