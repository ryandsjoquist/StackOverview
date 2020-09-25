//
//  ItemCustomTableCell.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/24/20.
//

import UIKit

class ItemCustomTableCell: UITableViewCell {
    
    // TODO: Convert these to private and set via internal strings, or by setup function
    var item: StackOFQuestion? {
        didSet {
            questionTitleLabel?.text = item?.title
            questionScoreLabel?.text = item?.score
        }
    }
    @IBOutlet weak var questionTitleLabel: UILabel?
    @IBOutlet weak var questionNumberLabel: UILabel?
    @IBOutlet weak var timestampLabel: UILabel?
    @IBOutlet weak var answerCountLabel: UILabel?
    @IBOutlet weak var acceptedAnswerIdLabel: UILabel?
    @IBOutlet weak var questionScoreLabel: UILabel?
    
    //Possibly move to separate cell at some point for reuse
    @IBOutlet weak var userReputationLabel: UILabel?
    @IBOutlet weak var usernameLabel: UILabel?
    @IBOutlet weak var userIcon: UIImageView?
    
    var userIconString: String = "" {
        didSet {
            Utilities.imageForUrl(urlString: userIconString) { [weak self] image, string in
                self?.userIcon?.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLabels()
    }
    
    func setUpLabels() {
        self.contentView.backgroundColor = .clear
        
        questionTitleLabel?.layer.borderWidth = 0.2
        questionTitleLabel?.layer.borderColor = .init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)

        acceptedAnswerIdLabel?.layer.cornerRadius = 2
        acceptedAnswerIdLabel?.layer.borderWidth = 0.5
        acceptedAnswerIdLabel?.layer.borderColor = .init(gray: 0.8, alpha: 1)
    }
    
    @IBAction func selectedAnswerWasTouched(sender: Any) {
        
    }
    
}
