//
//  NetworkDataStructs.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/23/20.
//

import Foundation

struct DataStackOverflowItem: Codable {
    let owner: DataStackOverflowOwner?
    let down_vote_count: Int?
    let up_vote_count: Int?
    let is_accepted: Bool?
    let score: Int?
    let last_activity_date: Int?
    let last_edit_date: Int?
    let creation_date: Int?
    let answer_id: Int?
    let question_id: Int?
    let link: String?
    let title: String?
    let body: String?
    
    init(owner: DataStackOverflowOwner?,
         downVoteCount: Int?,
         upVoteCount: Int?,
         isAccepted: Bool?,
         score: Int?,
         lastActivityDate: Int?,
         lastEditDate: Int?,
         creationDate: Int?,
         answerId: Int?,
         questionId: Int?,
         link: String?,
         title: String?,
         body: String?
    ) {
        self.owner = owner
        self.down_vote_count = downVoteCount
        self.up_vote_count = upVoteCount
        self.is_accepted = isAccepted
        self.score = score
        self.last_activity_date = lastActivityDate
        self.last_edit_date = lastEditDate
        self.creation_date = creationDate
        self.answer_id = answerId
        self.question_id = questionId
        self.link = link
        self.title = title
        self.body = body
    }
}

struct DataStackOverflowOwner: Codable {
    let reputation: Int?
    let user_id: Int?
    let user_type: String?
    let accept_rate: Int?
    let profile_image: String?
    let display_name: String?
    let link: String?
    
    init(reputation: Int?,
         userId: Int?,
         userType: String?,
         acceptRate: Int?,
         profileImage: String?,
         displayName: String?,
         link: String?) {
        self.reputation = reputation
        self.user_id = userId
        self.user_type = userType
        self.accept_rate = acceptRate
        self.profile_image = profileImage
        self.display_name = displayName
        self.link = link
    }
}

struct StackOFAnswers {
    let owner: StackOFOwner
    let lastActivityDate: Int
    let lastEditDate: Int
    let creationDate: Int
    let answerId: Int
    let questionId: Int
    let link: String
    let title: String
    let body: String
}

struct StackOFOwner {
    let reputation: Int
    let user_id: Int
    let user_type: String
    let accept_rate: Int
    let profile_image: String
    let display_name: String
    let link: String
}

class DataObjects {
    
}
