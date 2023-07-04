//
//  FoodsTableViewCell.swift
//  FoodsMenu
//
//  Created by Furkan on 1.07.2023.
//

import UIKit
import SDWebImage

class FoodsTableViewCell: UITableViewCell {

    static let identifier = "FoodsTableViewCell"
    
     let foodsImageView: UIImageView = {
        let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.layer.cornerRadius = 10
         imageView.clipsToBounds = true
         imageView.layer.masksToBounds = true
        return imageView
    }()

    
     let foodsNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let foodsPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.textColor = .gray
        return label
    }()
    
     let foodsRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rateIconButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        return button
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(foodsImageView)
        contentView.addSubview(foodsNameLabel)
        contentView.addSubview(foodsPriceLabel)
        contentView.addSubview(foodsRateLabel)
        contentView.addSubview(rateIconButton)
        
        applyConstraints()
        
    }
    
    
    
    private func applyConstraints() {
        
        let foodsImageViewConstraints = [
            foodsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            foodsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            foodsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            foodsImageView.heightAnchor.constraint(equalToConstant: 200),
        ]
        
        let foodsNameLabelConstraints = [
            foodsNameLabel.topAnchor.constraint(equalTo: foodsImageView.bottomAnchor, constant: 10),
            foodsNameLabel.leadingAnchor.constraint(equalTo: foodsImageView.leadingAnchor)
        ]
        
        let foodsPriceLabelConstraints = [
            foodsPriceLabel.topAnchor.constraint(equalTo: foodsNameLabel.bottomAnchor, constant: 10),
            foodsPriceLabel.leadingAnchor.constraint(equalTo: foodsNameLabel.leadingAnchor),
            foodsPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ]
        let rateIconButtonConstraints = [
            rateIconButton.topAnchor.constraint(equalTo: foodsNameLabel.topAnchor),
            rateIconButton.trailingAnchor.constraint(equalTo: foodsRateLabel.leadingAnchor, constant: -3)
        ]
        let foodsRateLabelConstraints = [
            foodsRateLabel.topAnchor.constraint(equalTo: rateIconButton.topAnchor, constant: 0.5),
            foodsRateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(foodsImageViewConstraints)
        NSLayoutConstraint.activate(foodsNameLabelConstraints)
        NSLayoutConstraint.activate(foodsPriceLabelConstraints)
        NSLayoutConstraint.activate(rateIconButtonConstraints)
        NSLayoutConstraint.activate(foodsRateLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: FoodsViewModel){
        guard let url = URL(string: "\(model.foodsImage)") else { return }
        foodsImageView.sd_setImage(with: url, completed: nil)
        foodsNameLabel.text = model.foodsName
        foodsPriceLabel.text = model.foodsprice
        foodsRateLabel.text = model.foodsrates
    }
}
