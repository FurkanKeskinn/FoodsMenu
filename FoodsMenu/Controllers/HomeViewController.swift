//
//  ViewController.swift
//  FoodsMenu
//
//  Created by Furkan on 25.06.2023.
//

import UIKit

enum Item: Int {
    case All = 0
    case BestFoods = 1
    case Bbqs = 2
    case Breads = 3
    case Burgers = 4
    case Chocolates = 5
    case Desserts = 6
    case Drinks = 7
    case FriedChicken = 8
    case IceCream = 9
    case Pizzas = 10
    case Porks = 11
    case Sandwiches = 12
    case Sausages = 13
    case Steaks = 14
}

class HomeViewController: UIViewController {
    
     var sectionTitles : [String] = ["All", "Best Foods", "Bbqs", "Breads", "Burgers", "Chocolates", "Desserts", "Drinks", "Fried Chicken", "Ice Cream", "Pizzas", "Porks", "Sandwiches", "Sausages", "Steaks"]
    
    private var foods: Foods = Foods()
    
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
        
        fetchFirstData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
        
    }
    
    private func fetchFirstData() {
        APICaller.shared.getAllFooods {[weak self] result in
            switch result {
            case .success(let foodss):
                self?.foods = foodss
                DispatchQueue.main.async {
                    self?.foodsTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodsTableViewCell.identifier, for: indexPath) as? FoodsTableViewCell else { return UITableViewCell() }
        let food = foods[indexPath.row]
        cell.configure(with: FoodsViewModel(foodsName: food.name ?? "", foodsImage: food.img ?? "", foodsrates: String(food.rate ?? 0) , foodsprice: String(food.price ?? 0) ))
        
       /* cell.foodsImageView.image = UIImage(named: "joes")
        cell.foodsNameLabel.text = "Joe's KC BBQ"
        cell.foodsPriceLabel.text = "110.99 $"
        cell.foodsRateLabel.text = "5"*/
        
            
        
        
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
                switch indexPath.item {
                    
                case Item.All.rawValue:
                    APICaller.shared.getAllFooods {[weak self] result in
                        switch result {
                        case .success(let foodss):
                            self?.foods = foodss
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Item.BestFoods.rawValue:
                    APICaller.shared.getBestFooods{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Item.Bbqs.rawValue:
                    APICaller.shared.getBbqs{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Item.Breads.rawValue:
                    APICaller.shared.getBreads{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Item.Burgers.rawValue:
                    APICaller.shared.getBurgers{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                case Item.Chocolates.rawValue:
                    
                    APICaller.shared.getChocolates{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.Desserts.rawValue:
                    
                    APICaller.shared.getDesserts{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.Drinks.rawValue:
                    
                    APICaller.shared.getDrinks{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.FriedChicken.rawValue:
                    
                    APICaller.shared.getFriedChicken{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.IceCream.rawValue:
                    
                    APICaller.shared.getIceCream{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.Pizzas.rawValue:
                    
                    APICaller.shared.getPizzas{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.Porks.rawValue:
                    
                    APICaller.shared.getPorks{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.Sandwiches.rawValue:
                    
                    APICaller.shared.getSandwiches{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.Sausages.rawValue:
                    
                    APICaller.shared.getSausages{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case Item.Steaks.rawValue:
                    
                    APICaller.shared.getSteaks{[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                default:
                    print("Error")
                    
                }
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

