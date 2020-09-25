//
//  HomeViewController.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/22/20.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myItems:[Any] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.mainTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = 
        return UITableViewCell()
    }
    
    @IBOutlet var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DataServices.loadItemsFromRequest()
        myItems = DataServices.questions
        // Do any additional setup after loading the view.
    }


}

