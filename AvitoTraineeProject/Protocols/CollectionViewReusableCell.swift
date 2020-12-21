//
//  CollectionViewReusableCell.swift
//  AvitoTraineeProject
//
//  Created by Рыжков Артем on 21.12.2020.
//

import Foundation

protocol CollectionViewReusableCell {}

extension CollectionViewReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
