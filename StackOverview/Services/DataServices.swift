//
//  DataServices.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/23/20.
//

import Foundation

class DataServices {
    
    static var questions: [StackOFQuestion] = []
    static var answers: [StackOFAnswer] = [] 
    
    static func loadItemsFromRequest() {
        NetworkServices.loadStackOFAnswers(requestResultType: .questions,
                                           requestResultSite: .stackoverflow) { items in
            convertDataToLocalItems(items)
        }
    }
    
    static func convertDataToLocalItems(_ items: [DataStackOverflowItem]) {
        for item in items {
            let localOwner = StackOFOwner.init(reputation: item.owner?.reputation ?? 0, user_id: item.owner?.user_id ?? 0, user_type: item.owner?.user_type ?? "", accept_rate: item.owner?.accept_rate ?? 0, profile_image: item.owner?.profile_image ?? "", display_name: item.owner?.display_name ?? "", link: item.owner?.link ?? "")
            if item.answer_id != nil {
/*
                Answers have both questionID and answerID,
                questions do not have the answerID.
                So we first check for answers in our items,
                if we're returning a mixed bag of values depending on query type.
 */
                let newAnswer = StackOFAnswer.init(owner: localOwner,
                                                   lastActivityDate: Utilities.convertIntToDate(dateAsInt: item.last_activity_date),
                                                   lastEditDate: Utilities.convertIntToDate(dateAsInt: item.last_edit_date),
                                                   creationDate: Utilities.convertIntToDate(dateAsInt: item.creation_date),
                                                   answerId: item.answer_id ?? 123123,
                                                   questionId: item.question_id ?? 123123,
                                                   link: item.link ?? "",
                                                   title: item.title,
                                                   body: item.body)
                answers.append(newAnswer)
            } else if item.answer_count ?? 0 > 0 || item.accepted_answer_id != nil {
                let newQuestion = StackOFQuestion.init(owner: localOwner,
                                                       isAnswered: item.is_answered ?? false,
                                                       acceptedAnswerId: item.accepted_answer_id,
                                                       answerCount: item.answer_count,
                                                       score: item.score ?? 0,
                                                       lastActivityDate: Utilities.convertIntToDate(dateAsInt: item.last_activity_date),
                                                       lastEditDate: Utilities.convertIntToDate(dateAsInt: item.last_edit_date),
                                                       creationDate: Utilities.convertIntToDate(dateAsInt: item.creation_date),
                                                       questionId: item.question_id ?? 456456,
                                                       link: item.link ?? "Link",
                                                       title: item.title ?? "Title")
                questions.append(newQuestion)
            }
        }
    }
}


