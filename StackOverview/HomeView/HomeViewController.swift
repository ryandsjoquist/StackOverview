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
        let item = myItems[indexPath.row]
        mainTableView.beginUpdates()
        // I hate force unwrapping, but I know this cell will be the custom type, so I make this one exception
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! ItemCustomTableCell
        if let questionItem = item as? StackOFQuestion {
            cell.questionTitleLabel?.text = questionItem.title
            cell.answerCountLabel?.text? = "# of Answers: \(questionItem.answerCount ?? 0)"
            cell.timestampLabel?.text = questionItem.creationDate
            cell.questionNumberLabel?.text = "Q ID: \(questionItem.questionId)"
            cell.acceptedAnswerIdLabel?.text = "Preferred Answer: \(questionItem.acceptedAnswerId ?? 0)"
            cell.userIconString = questionItem.owner.profile_image
            cell.usernameLabel?.text = questionItem.owner.display_name
            cell.questionScoreLabel?.text = "Score: \(questionItem.score)"
            cell.userReputationLabel?.text = "Reputation: \(questionItem.owner.reputation)"
        } else if let answerItem = item as? StackOFAnswer {
            cell.questionTitleLabel?.text = answerItem.title
        }
        mainTableView.endUpdates()
        return cell
    }
    
    @IBOutlet var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.register(UINib(nibName: "ItemCustomTableCell", bundle: nil), forCellReuseIdentifier: "customCell")
        NetworkServices.loadStackOFRequest(requestResultType: .questions,
                                           requestResultSite: .stackoverflow) { [weak self] items in
            self?.myItems = DataServices.convertDataToLocalQuestion(items)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(myItems.count)")
    }


}

