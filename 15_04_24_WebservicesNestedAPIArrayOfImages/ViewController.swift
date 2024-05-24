//
//  ViewController.swift
//  15_04_24_WebservicesNestedAPIArrayOfImages
//
//  Created by Vishal Jagtap on 24/05/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var products : [Product] = []
    var imageURLStrings : [String] = []
    private let reuseIdetifierForCell = "ProductTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        parseJSON()
        registerProductTableViewWithXIB()
    }
    
    func initViews(){
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    func registerProductTableViewWithXIB(){
       let uiNIB = UINib(nibName: reuseIdetifierForCell, bundle: nil)
        self.productsTableView.register(uiNIB, forCellReuseIdentifier: reuseIdetifierForCell)
    }
    
    func parseJSON(){
        url = URL(string: "https://api.escuelajs.co/api/v1/products")
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for eachProduct in jsonResponse{
                let eachProductId = eachProduct["id"] as! Int
                let eachProductTitle = eachProduct["title"] as! String
                let eachProductPrice = eachProduct["price"] as! Int
                let eachProductDescription = eachProduct["description"] as! String
                self.imageURLStrings = eachProduct["images"] as! [String]
                
                let newPorductObject = Product(
                    id: eachProductId,
                    title: eachProductTitle,
                    price: eachProductPrice,
                    description: eachProductDescription,
                    images: self.imageURLStrings)
                
                self.products.append(newPorductObject)
                
                DispatchQueue.main.async {
                    self.productsTableView.reloadData()
                }
            }
        })
        dataTask?.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productTableViewCell = self.productsTableView.dequeueReusableCell(withIdentifier: reuseIdetifierForCell, for: indexPath) as! ProductTableViewCell
        
        for eachImageURLSTring in self.products[indexPath.row].images{
            let url1 = URL(string: eachImageURLSTring)
            productTableViewCell.productImageView.kf.setImage(with: url1)
        }
        
        return productTableViewCell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185.0
    }
}
