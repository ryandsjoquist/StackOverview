//
//  DataServices.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/23/20.
//

import Foundation

class DataServices {
    
    static func convertDataOwnerToLocalOwner(item: DataStackOverflowOwner?) -> StackOFOwner {
        return StackOFOwner.init(reputation: item?.reputation ?? 0,
                                 user_id: item?.user_id ?? 0,
                                 user_type: item?.user_type ?? "",
                                 accept_rate: item?.accept_rate ?? 0,
                                 profile_image: item?.profile_image ?? "",
                                 display_name: item?.display_name ?? "",
                                 link: item?.link ?? "")
    }
    
    static func convertDataToLocalQuestion(_ items: [DataStackOverflowItem]) -> [StackOFQuestion] {
        var questions: [StackOFQuestion] = []
        for item in items {
            let localOwner = convertDataOwnerToLocalOwner(item: item.owner)
            if item.answer_count ?? 0 > 1 && item.accepted_answer_id != nil {
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
        return questions
    }
    
    static func convertDataToLocalAnswer(_ items: [DataStackOverflowItem]) -> [StackOFAnswer] {
        var answers: [StackOFAnswer] = []
        for item in items {
            let localOwner = convertDataOwnerToLocalOwner(item: item.owner)
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
            }
        }
        return answers
    }
}


