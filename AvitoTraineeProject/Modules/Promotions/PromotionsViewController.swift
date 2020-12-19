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

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }
}
