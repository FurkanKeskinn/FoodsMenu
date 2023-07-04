//
//  TitleCollectionViewCell.swift
//  FoodsMenu
//
//  Created by Furkan on 2.07.2023.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
       }()
    
    override var isSelected: Bool {
            didSet {
                updateCellAppearance()
            }
        }
    
       override init(frame: CGRect) {
           super.init(frame: frame)
           addSubview(titleLabel)
           
              NSLayoutConstraint.activate([
                  titleLabel.topAnchor.constraint(equalTo: topAnchor),
                  titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                  titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                  titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
              ])
           
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
        private func updateCellAppearance() {
            if isSelected {
                titleLabel.textColor = .red
                titleLabel.transform = CGAffineTransform(translationX: 0, y: -6)// Yukarı kaydırma animasyonu
            } else {
                titleLabel.textColor = .black
                titleLabel.transform = .identity
            }
        }
}
