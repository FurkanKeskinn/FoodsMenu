//
//  APICaller.swift
//  FoodsMenu
//
//  Created by Furkan on 4.07.2023.
//

import Foundation

struct Constants {
    static let baseURL = "https://free-food-menus-api-production.up.railway.app/"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    
    func getAllFooods(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)our-foods") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getBestFooods(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)best-foods") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getBbqs(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)bbqs") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getBreads(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)breads") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getBurgers(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)burgers") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getChocolates(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)chocolates") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getDesserts(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)desserts") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    func getDrinks(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)drinks") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    func getFriedChicken(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)fried-chicken") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getIceCream(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)ice-cream") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getPizzas(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)pizzas") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    func getPorks(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)porks") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getSandwiches(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)sandwiches") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getSausages(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)sausages") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
    
    func getSteaks(completion: @escaping (Result<Foods, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)steaks") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(Foods.self, from: data)
                completion(.success(results))
                print(results)
            }catch{
                completion(.failure(APIError.failedTogetData))
                print(error.localizedDescription)
                
            }
        }
        task.resume()
    }
}
