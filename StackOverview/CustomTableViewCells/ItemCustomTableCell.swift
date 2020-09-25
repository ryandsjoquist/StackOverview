//
//  ItemCustomTableCell.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/24/20.
//

import UIKit

class ItemCustomTableCell: UITableViewCell {
    
    public var delegate: SelectedAnswerProtocol?
    
    // TODO: Convert these to private and set via internal strings, or by setup function
    public var item: StackOFQuestion? {
        didSet {
            questionTitleLabel?.text = item?.title
            answerCountLabel?.text? = "# of Answers: \(item?.answerCount ?? 0)"
            timestampLabel?.text = item?.creationDate
            setAttributedStringsForButtons()
            userIconString = item?.owner.profile_image ?? ""
            usernameLabel?.text = item?.owner.display_name
            questionScoreLabel?.text = "Score: \(item?.score ?? 0)"
            userReputationLabel?.text = "Reputation: \(item?.owner.reputation ?? 0)"
        }
    }
    @IBOutlet private weak var questionTitleLabel: UILabel?
    @IBOutlet private weak var questionNumberButton: UIButton?
    @IBOutlet private weak var timestampLabel: UILabel?
    @IBOutlet private weak var answerCountLabel: UILabel?
    @IBOutlet private weak var acceptedAnswerIdButton: UIButton?
    @IBOutlet private weak var questionScoreLabel: UILabel?
    
    //Possibly move to separate cell at some point for reuse
    @IBOutlet private weak var userReputationLabel: UILabel?
    @IBOutlet private weak var usernameLabel: UILabel?
    @IBOutlet private weak var userIcon: UIImageView?
    
    private var userIconString: String = "" {
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
    
    func setAttributedStringsForButtons() {
        let questionIDAttString = NSAttributedString(string: "Question ID: \(item?.questionId ?? 0)", attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),
            NSAttributedString.Key.underlineStyle:1.0
        ])
        let acceptedAnswerAttString = NSAttributedString(string: "Top Answer: \(item?.acceptedAnswerId ?? 0)", attributes:[
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),
            NSAttributedString.Key.underlineStyle:1.0
        ])
        questionNumberButton?.setAttributedTitle(questionIDAttString, for: .normal)
        acceptedAnswerIdButton?.setAttributedTitle(acceptedAnswerAttString, for: .normal)
    }
    
    func setUpLabels() {
        self.contentView.backgroundColor = .clear
        acceptedAnswerIdButton?.titleLabel?.adjustsFontForContentSizeCategory = true
        questionTitleLabel?.layer.borderWidth = 0.2
        questionTitleLabel?.layer.borderColor = .init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    }
    
    @IBAction func questionIdSelected(sender: Any) {
        if let questionId = item?.questionId {
            delegate?.questionSelected(questionId: questionId)
        }
    }
    
    @IBAction func answerWasSelected(sender: Any) {
        if let answerId = item?.acceptedAnswerId {
            delegate?.answerSelected(answerId: answerId)
        }
    }
    
}
