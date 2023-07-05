//
//  SearchTableViewCell.swift
//  FoodsMenu
//
//  Created by Furkan on 4.07.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "test"
        return label
    }()
    
    let foodImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "joes")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(foodImageView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        let nameLabelConstraints = [
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: foodImageView.leadingAnchor, constant: -10)
        ]
        
        let imageViewConstraints = [
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            foodImageView.widthAnchor.constraint(equalToConstant: 120),
            foodImageView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    func configure(with model: FoodsViewModel){
        guard let url = URL(string: "\(model.foodsImage)") else { return }
        foodImageView.sd_setImage(with: url, completed: nil)
        nameLabel.text = model.foodsName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
