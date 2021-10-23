//
//  LoadingCollectionViewCell.swift
//  HepsiburadaCase
//
//  Created by Kursat on 20.10.2021.
//

import Foundation
import UIKit
import Reusable

class LoadingCollectionViewCell: UICollectionViewCell, Reusable {
    
    let loadingLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(loadingLabel)
        contentView.backgroundColor = .systemGray4
        loadingLabel.text = "⚠️LOADING⚠️"
        loadingLabel.font = UIFont.italicSystemFont(ofSize: 16.0)
        loadingLabel.sizeToFit()
        loadingLabel.center = contentView.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
