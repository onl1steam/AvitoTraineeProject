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
    
    private var selectedCell: PromoCollectionViewCell?
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "CloseIconTemplate"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.text = "Сделайте объявление заметнее на 7 дней"
        label.numberOfLines = 0
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        let nib = UINib(nibName: "PromoCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "PromoCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .white
        return collection
    }()
    
    private let chooseButton: RoundedButton = {
        let button = RoundedButton()
        button.cornerRadius = 8
        button.setTitle("Выбрать", for: .normal)
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
        collectionView.dataSource = self
        
        presenter.configureView()
    }
    
    func changeButtonTitle(_ title: String) {
        chooseButton.setTitle(title, for: .normal)
    }
    
    func updateCollectionView() {
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
            chooseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            chooseButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            chooseButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            chooseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension PromotionsViewController: UICollectionViewDelegateFlowLayout {}

extension PromotionsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PromoCollectionViewCell
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
}

extension PromotionsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getPromotionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCollectionViewCell",
                                                            for: indexPath) as? PromoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: presenter.getPromotion(for: indexPath.row))
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
