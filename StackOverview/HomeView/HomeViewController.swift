//
//  HomeViewController.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/22/20.
//

import UIKit
import SafariServices

protocol SelectedAnswerProtocol {
    func answerSelected(answerId: Int)
    func questionSelected(questionId: Int)
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SelectedAnswerProtocol  {
    
    func questionSelected(questionId: Int) {
        let destination = URL.init(string: "https://\(StackOverflowRequestSite.stackoverflow.rawValue).com/q/\(questionId)")
        if let destURL = destination {
            let safariController = SFSafariViewController.init(url: destURL)
            self.present(safariController, animated: true, completion: nil)
        }
    }
    
    func answerSelected(answerId: Int) {
        
        let destination = URL.init(string: "https://\(StackOverflowRequestSite.stackoverflow.rawValue).com/a/\(answerId)")
        if let destURL = destination {
            let safariController = SFSafariViewController.init(url: destURL)
            self.present(safariController, animated: true, completion: nil)
        }
    }
    
    
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
        let item = myItems[indexPath.row]
        mainTableView.beginUpdates()
        // I hate force unwrapping, but I know this cell will be the custom type, so I make this one exception
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! ItemCustomTableCell
        if let questionItem = item as? StackOFQuestion {
            cell.item = questionItem
            cell.delegate = self
        }
        mainTableView.endUpdates()
        return cell
    }
    
    @IBOutlet var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.register(UINib(nibName: "ItemCustomTableCell", bundle: nil), forCellReuseIdentifier: "customCell")
        NetworkServices.loadStackOFRequest(requestResultType: .questions,
                                           requestResultSite: .stackoverflow,
                                           requestQuery: nil) { [weak self] items in
            self?.myItems = DataServices.convertDataToLocalQuestion(items)
        }
    }
    
    func loadSelectedAnswer(answerLink: String) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(myItems.count)")
    }


}

