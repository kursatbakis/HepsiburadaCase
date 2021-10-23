//
//  CollectionViewCell.swift
//  HepsiburadaCase
//
//  Created by Kursat on 19.10.2021.
//

import Foundation
import Reusable
import Kingfisher

class CollectionViewCell: UICollectionViewCell, Reusable {
    
    let nameLabel = UILabel(frame: .zero)
    let imageView = UIImageView(frame: .zero)
    let priceLabel = UILabel(frame: .zero)
    let releaseDateLabel = UILabel(frame: .zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        [nameLabel, imageView, priceLabel, releaseDateLabel].forEach(contentView.addSubview)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        imageView.backgroundColor = .darkGray
        imageView.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5.0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
    
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        priceLabel.textAlignment = .left
        priceLabel.sizeToFit()
        
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        releaseDateLabel.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 10.0).isActive = true
        releaseDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        releaseDateLabel.textAlignment = .left
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.systemOrange.cgColor
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
        
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(with item: Result) {
        let date = Formatter.dateFormatter.date(from: item.releaseDate)
        
        nameLabel.attributedText = NSAttributedString(string: item.trackName, attributes: [.foregroundColor: UIColor.darkText, .font: UIFont.systemFont(ofSize: 16.0, weight: .medium)])
        imageView.kf.setImage(with: URL(string: item.artworkUrl100)!)
        priceLabel.attributedText = NSAttributedString(string: "\(item.collectionPrice ?? 0)$", attributes: [.foregroundColor: UIColor.systemGray, .font: UIFont.systemFont(ofSize: 14.0)])
        releaseDateLabel.attributedText = NSAttributedString(string: String(item.releaseDate.prefix(4)), attributes: [.foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 14.0, weight: .semibold)])
        
    }
    
    
}
