//
//  NetworkDataStructs.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/23/20.
//

import UIKit

// future work for getting all stack overflow api request types

enum StackOverflowRequestType: String {
    case answers
    case badges
    case comments
    case events
    case info
    case posts
    case questions
    case search
    case tags
    case users
}

enum StackOverflowRequestSite: String {
    case stackoverflow
    case serverfault
    case superuser
    case meta
    case webapps
    case gaming
    case webmasters
}

/*
 We'll stick to just stackoverflow for now as there are many additional sites
 potentially under the API request site.
 
 this is the standard https://github.com/surfstudio/StackOv/tree/master/StackOv
 */

// We get only 30 returned items initially, which is totally fine.
struct DataStackOverflowResponse: Codable {
    let quota_remaining: Int?
    let quota_max: Int?
    let items: [DataStackOverflowItem]?
    let has_more: Bool?
    
    init(quotaRemaining: Int?, quotaMax: Int?, items: [DataStackOverflowItem]?, hasMore: Bool?) {
        self.quota_remaining = quotaRemaining
        self.quota_max = quotaMax
        self.items = items
        self.has_more = hasMore
    }
}

struct DataStackOverflowItem: Codable {
    let owner: DataStackOverflowOwner?
    let down_vote_count: Int?
    let up_vote_count: Int?
    let is_accepted: Bool?
    let is_answered: Bool?
    let score: Int?
    let answer_count: Int?
    let accepted_answer_id: Int?
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
         isAnswered: Bool?,
         score: Int?,
         answerCount: Int?,
         acceptedAnswerId: Int?,
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
        self.is_answered = isAnswered
        self.score = score
        self.answer_count = answerCount
        self.accepted_answer_id = acceptedAnswerId
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

struct StackOFQuestion {
    let owner: StackOFOwner
    let isAnswered: Bool
    let acceptedAnswerId: Int?
    let answerCount: Int?
    let score: Int
    let lastActivityDate: String
    let lastEditDate: String
    let creationDate: String
    let questionId: Int
    let link: String
    let title: String?
}

struct StackOFAnswer {
    let owner: StackOFOwner
    let lastActivityDate: String
    let lastEditDate: String
    let creationDate: String
    let answerId: Int
    let questionId: Int
    let link: String
    let title: String?
    let body: String?
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
