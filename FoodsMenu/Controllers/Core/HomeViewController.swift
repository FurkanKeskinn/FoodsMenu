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
    
    private var foods: [Food] = [Food]()
    
    // Variables to hold data fragments
    var allFoods: [Food] = [Food]() // Entire dataset
    var displayedFoods: [Food] = [] // Visible data fragment
    
    private let searchController : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
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
    
    private let searchTable : UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
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
        
        navigationController?.navigationBar.tintColor = .brown
        
        view.addSubview(foodsTable)
        view.addSubview(collectionView)
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        if let cell = collectionView.cellForItem(at: firstIndexPath) as? TitleCollectionViewCell {
            cell.isSelected = true
        }
        
        loadInitialData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
        searchTable.frame = view.bounds
        
    }
    
    func scrollToTopOfTableView() {
        let indexPath = IndexPath(row: 0, section: 0) // İlk satırın indexPath'ini oluştur
        
        if foodsTable.numberOfSections > 0 && foodsTable.numberOfRows(inSection: 0) > 0 {
            foodsTable.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func loadInitialData() {
        fetchFirstData()
        
        // Assigning the first fragment to the data fragment to be displayed
        displayedFoods = Array(allFoods.prefix(10)) // A fragment such as the first 10 items can be selected
        
        // Updating the TableView
        foodsTable.reloadData()
    }
    
    func loadNextChunkIfNeeded(for indexPath: IndexPath) {
        let lastRowIndex = foodsTable.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            let startIndex = displayedFoods.count
            let endIndex = min(startIndex + 10, allFoods.count) // A fragment such as 10 items can be selected
            
            // Loading new fragment data
            let newDataChunk = Array(allFoods[startIndex..<endIndex])
            
            // Adding new data to the visible data fragment
            displayedFoods += newDataChunk
            
            // Updating the TableView
            foodsTable.reloadData()
        }
    }

    private func fetchFirstData() {
        APICaller.shared.getAllFooods {[weak self] result in
            switch result {
            case .success(let foods):
                self?.foods = foods
                self?.allFoods = foods // Update the entire dataset
                DispatchQueue.main.async {
                    self?.displayedFoods = Array(foods.prefix(10))
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodsTableViewCell.identifier, for: indexPath) as? FoodsTableViewCell else { return UITableViewCell() }
        
        // Checking for a valid indexPath.row value
        if indexPath.row < displayedFoods.count {
            let food = displayedFoods[indexPath.row]
            cell.configure(with: FoodsViewModel(foodsName: food.name ?? "", foodsImage: food.img ?? "", foodsRates: String(food.rate ?? 0) , foodsPrice: String(food.price ?? 0) ))
            } else {
                cell.configure(with: FoodsViewModel(foodsName: "", foodsImage: "", foodsRates: "", foodsPrice: ""))
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foods[indexPath.row]
        guard let id = food.id else {return}
        
        APICaller.shared.getFood(with: id) { [weak self] result in
            switch result {
            case .success(let food):
                DispatchQueue.main.async {
                    let vc = FoodPreviewViewController()
                    vc.configure(with: PreviewViewModel(foodName: food.name ?? "", foodImage: food.img ?? "", foodRates: String(food.rate ?? 0), foodPrice: String(food.price ?? 0), foodDsc: food.dsc ?? "", foodCountry: food.country ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadNextChunkIfNeeded(for: indexPath)
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
                scrollToTopOfTableView()
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                switch indexPath.item {
                    
                case Item.All.rawValue:
                    APICaller.shared.getAllFooods {[weak self] result in
                        switch result {
                        case .success(let foods):
                            self?.foods = foods
                            self?.allFoods = foods
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
                                
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
                                
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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
                            self?.allFoods = foods
                            DispatchQueue.main.async {
                                self?.foodsTable.reloadData()
                                self?.displayedFoods = Array(foods.prefix(10))
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

extension HomeViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate{
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        resultsController.delegate = self
        let filteredFoods = searchFood(with: query)
        resultsController.foods = filteredFoods
        resultsController.searchResultTableView.reloadData()
    }
    
    func searchFood(with query: String) -> [Food] {
            let filteredFoods = foods.filter { food in
                return food.name?.localizedCaseInsensitiveContains(query) ?? false
            }
            return filteredFoods
        }
    
    func SearchResultsViewControllerDidTapItem(_ viewModel: PreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = FoodPreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

