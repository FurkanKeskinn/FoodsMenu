//
//  FoodPreviewViewController.swift
//  FoodsMenu
//
//  Created by Furkan on 4.07.2023.
//

import UIKit

class FoodPreviewViewController: UIViewController {

    private let imageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "joes")
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100 $"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBrown
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rateButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        button.setImage(image, for: .normal)
        button.tintColor = .systemBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "dafsafdsfadsadfsafdsafsdafsd dsafdsafdasfdasfasdfsad"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Turkey"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(rateLabel)
        view.addSubview(rateButton)
        view.addSubview(descriptionLabel)
        view.addSubview(countryLabel)
        configureContraints()
        
    }
    
    
    func configureContraints() {
         
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ]
    
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: rateButton.leadingAnchor,constant: -15)
        ]
        
        let rateLabelConstraints = [
            rateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ]
        
        let rateButtonConstraints =  [
            rateButton.centerYAnchor.constraint(equalTo: rateLabel.centerYAnchor),
            rateButton.trailingAnchor.constraint(equalTo: rateLabel.leadingAnchor, constant: -1)
        ]
        
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ]
        
        let countryLabelConstraints = [
            countryLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25),
            countryLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor)
        ]
        let priceLabelConstraints = [
            priceLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 40),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(rateLabelConstraints)
        NSLayoutConstraint.activate(rateButtonConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
        NSLayoutConstraint.activate(countryLabelConstraints)
        
        
    }
    
    func configure(with model: PreviewViewModel){
        guard let url = URL(string: model.foodImage) else { return }
        imageView.sd_setImage(with: url, completed: nil)
        nameLabel.text = model.foodName
        rateLabel.text = model.foodRates
        descriptionLabel.text =  model.foodDsc
        countryLabel.text = "Country: " + model.foodCountry
        priceLabel.text = model.foodPrice + " $"
    }

}
