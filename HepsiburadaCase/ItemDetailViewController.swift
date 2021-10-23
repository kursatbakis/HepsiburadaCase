//
//  ItemDetailViewController.swift
//  HepsiburadaCase
//
//  Created by Kursat on 19.10.2021.
//

import Foundation
import UIKit

class ItemDetailViewController: UIViewController {
    
    var item: Result
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let buyButton = UIButton(type: .roundedRect)
    let detailLabel = UILabel(frame: .zero)
    let explicitLabel = UILabel(frame: .zero)
    let genreNameLabel = UILabel(frame: .zero)
    
    init(item: Result) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(white: 0.1, alpha: 1.0)
        navigationItem.title = item.trackName
        [imageView, titleLabel, buyButton, detailLabel, explicitLabel, genreNameLabel].forEach(view.addSubview)
        imageView.kf.setImage(with: URL(string: item.artworkUrl100)!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        imageView.layer.cornerRadius = 5.0
        imageView.layer.masksToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = NSAttributedString(string: item.trackName, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20.0, weight: .semibold)])
        
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        buyButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
        buyButton.setAttributedTitle(NSAttributedString(string: "BUY \(item.collectionPrice ?? 0)$", attributes: [.foregroundColor: UIColor.systemBlue, .font: UIFont.systemFont(ofSize: 14.0)]), for: .normal)
        buyButton.backgroundColor = .clear
        buyButton.layer.borderWidth = 2.0
        buyButton.layer.borderColor = UIColor.systemBlue.cgColor
        buyButton.layer.cornerRadius = 5.0
        buyButton.layer.masksToBounds = true
        
        explicitLabel.translatesAutoresizingMaskIntoConstraints = false
        explicitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        explicitLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        explicitLabel.layer.borderWidth = 2.0
        explicitLabel.layer.borderColor = UIColor.white.cgColor
        explicitLabel.layer.cornerRadius = 3.0
        explicitLabel.layer.masksToBounds = true
        explicitLabel.textAlignment = .center
        explicitLabel.attributedText = NSAttributedString(string: item.explicitness ?? " NON-EXPLICIT ", attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 13.0)])
        
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.topAnchor.constraint(equalTo: genreNameLabel.bottomAnchor, constant: 15.0).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        detailLabel.textAlignment = .left
        detailLabel.numberOfLines = 0
        detailLabel.attributedText = NSAttributedString(string: item.longDescription ?? "No description for this product.", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 16.0, weight: .light)])
        
        genreNameLabel.translatesAutoresizingMaskIntoConstraints = false
        genreNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10.0).isActive = true
        genreNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        genreNameLabel.textAlignment = .left
        genreNameLabel.attributedText = NSAttributedString(string: item.primaryGenreName ?? "", attributes: [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 13.0, weight: .regular)])
    }
}
