//
//  ViewController.swift
//  FoodsMenu
//
//  Created by Furkan on 25.06.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
     var sectionTitles : [String] = ["All", "Bbqs", "Best-foods", "Breads", "Burgers", "Chocolates", "Desserts", "Drinks", "Fried Chicken", "Ice Cream", "Pizzas", "Porks", "Sandwiches", "Sausages", "Steaks"]
    
    private let searchController : UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Search for a Foods"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private let foodsTable: UITableView = {
       let table = UITableView()
        table.register(FoodsTableViewCell.self, forCellReuseIdentifier: FoodsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
        
    }()
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15) // Sola ve Sağa boşluk
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        foodsTable.dataSource = self
        foodsTable.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        view.addSubview(foodsTable)
        view.addSubview(collectionView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Select the first item in the collection view
        let firstIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        if let cell = collectionView.cellForItem(at: firstIndexPath) as? TitleCollectionViewCell {
            cell.isSelected = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
        
    }
    
    private func applyConstraints() {
        let foodsTableConstraints = [
            foodsTable.topAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.bottomAnchor),
            foodsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foodsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(foodsTableConstraints)

        let menuCollectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(menuCollectionViewConstraints)
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodsTableViewCell.identifier, for: indexPath) as? FoodsTableViewCell else { return UITableViewCell() }
        
        cell.foodsImageView.image = UIImage(named: "joes")
        cell.foodsNameLabel.text = "Joe's KC BBQ"
        cell.foodsPriceLabel.text = "110.99 $"
        cell.foodsRateLabel.text = "5"
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TitleCollectionViewCell
        cell.titleLabel.text = sectionTitles[indexPath.item]
        
        return cell
    }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? TitleCollectionViewCell {
                cell.isSelected = true
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                       
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? TitleCollectionViewCell {
                cell.isSelected = false
            }
        }
    
    
    
}


extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController else {
            return
        }
        //
    }
    
    
}

