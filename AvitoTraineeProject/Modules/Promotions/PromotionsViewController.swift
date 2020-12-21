//
//  PromotionsViewController.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 19.12.2020.
//

import UIKit

final class PromotionsViewController: UIViewController, PromotionsViewProtocol {
    
    var configurator: PromotionsConfiguratorProtocol = PromotionsConfigurator()
    var presenter: PromotionsPresenterProtocol!
    
    private var selectedCell: PromotionCollectionViewCell?
    private var dataSource: PromotionsCollectionDataSource?
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "CloseIconTemplate"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        
        collection.register(PromotionCollectionViewCell.self,
                            forCellWithReuseIdentifier: PromotionCollectionViewCell.reuseIdentifier)
        
        // let nib = UINib(nibName: "PromoCollectionViewCell", bundle: nil)
        // collection.register(nib, forCellWithReuseIdentifier: PromoCollectionViewCell.reuseIdentifier)
        
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .white
        return collection
    }()
    
    private let chooseButton: RoundedButton = {
        let button = RoundedButton()
        button.cornerRadius = 8
        button.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.6745098039, blue: 1, alpha: 1)
        button.tintColor = .white
        button.addTarget(nil, action: #selector(chooseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        configurator.configure(with: self)
        
        setupCloseButtonPosition()
        setupTitleLabelPosition()
        setupChooseButtonPosition()
        setupCollectionViewPosition()
        
        collectionView.delegate = self
        dataSource = PromotionsCollectionDataSource(presenter: presenter)
        collectionView.dataSource = dataSource
        
        presenter.configureView()
    }
    
    func changeButtonTitle(_ title: String) {
        chooseButton.setTitle(title, for: .normal)
    }
    
    func updateCollectionView(with promotionList: [PromotionViewModel]) {
        dataSource?.update(with: promotionList)
        collectionView.reloadData()
    }
    
    func setPromotionInfo(_ promotionInfo: PromotionInfoViewModel) {
        titleLabel.text = promotionInfo.title
        chooseButton.setTitle(promotionInfo.actionTitle, for: .normal)
    }
    
    func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func chooseButtonTapped() {
        presenter.chooseButtonTapped()
    }
    
    private func setupCloseButtonPosition() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupTitleLabelPosition() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func setupCollectionViewPosition() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: chooseButton.topAnchor, constant: -20)
        ])
    }
    
    private func setupChooseButtonPosition() {
        view.addSubview(chooseButton)
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            chooseButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            chooseButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            chooseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension PromotionsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PromotionCollectionViewCell
        guard let row = presenter.selectedPromoNumber else {
            cell?.changeCheckmarkVisibility(isHidden: false)
            selectedCell = cell
            presenter.cellTapped(row: indexPath.row)
            return
        }
        
        guard row != indexPath.row else {
            cell?.changeCheckmarkVisibility(isHidden: true)
            selectedCell = cell
            presenter.cellTapped(row: nil)
            return
        }
        
        selectedCell?.changeCheckmarkVisibility(isHidden: true)
        cell?.changeCheckmarkVisibility(isHidden: false)
        selectedCell = cell
        presenter.cellTapped(row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let size = CGSize(width: width, height: 150)
        return size
    }
}
