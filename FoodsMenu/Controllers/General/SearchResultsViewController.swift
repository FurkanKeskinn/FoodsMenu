//
//  SearchResultsViewController.swift
//  FoodsMenu
//
//  Created by Furkan on 4.07.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func SearchResultsViewControllerDidTapItem(_ viewModel: PreviewViewModel)
}
class SearchResultsViewController: UIViewController {

    var foods: [Food] = [Food]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    let searchResultTableView : UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
        
        view.addSubview(searchResultTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultTableView.frame = view.bounds
    }
    
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
            
        }
        let food = foods[indexPath.row]
        cell.configure(with: FoodsViewModel(foodsName: food.name ?? "", foodsImage: food.img ?? "", foodsRates: "", foodsPrice: ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foods[indexPath.row]
        
        guard let id = food.id else {return}
        
        APICaller.shared.getFood(with: id) { [weak self] result in
            switch result {
            case .success(let food):
                self?.delegate?.SearchResultsViewControllerDidTapItem(PreviewViewModel(foodName: food.name ?? "", foodImage: food.img ?? "", foodRates: String(food.rate ?? 0), foodPrice: String(food.price ?? 0), foodDsc: food.dsc ?? "", foodCountry: food.country ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
