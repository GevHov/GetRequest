//
//  ViewController.swift
//  Exercise
//
//  Created by Gevorg Hovhannisyan on 21.10.21.
//
import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var result: [Result] = []

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        return tableView

    }()

    private var data = [String]()

    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
    }
    
    @IBAction func getRequest(_ sender: Any) {
        
        var sURL: String!
        
        sURL = "https://www.helix.am/temp/json.php"
        
        let serializer = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))
        
        let sampleRequest = URLRequest (url: URL(string: sURL)!)
        
        AF.request(sampleRequest).uploadProgress{ progress in
        }.response(responseSerializer: serializer){ response in
            
        if (response.error == nil)
        {
            var responseString: String!
            
            responseString = ""
            
            if (response.data != nil)
            {
                responseString = String(bytes: response.data!, encoding: .utf8)
            }
            else
            {
                responseString = response.response!.description
            }
            print(responseString ?? "")
            
            print(response.response?.statusCode as Any)
        }
            
        }
    }
}
        
     
//MARK: - EXTENSIONS
extension ViewController: UITableViewDataSource, UIScrollViewDelegate, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if result.count - 2 == indexPath.row {
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
}
