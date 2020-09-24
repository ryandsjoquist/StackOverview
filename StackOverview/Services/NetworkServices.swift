//
//  DataServices.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/22/20.
//

import Foundation

class DataServices {
    static func loadStackOFAnswers(completionHandler: @escaping ([StackOFAnswers]) -> ()) {
        //TODO: make site and type of return, currently answers for stackoverflow an enum to let people search for questions or other things for StackOverflow sibling sites.
        guard let url = URL(string: "https://api.stackexchange.com/2.2/answers?order=desc&sort=activity&site=stackoverflow") else { return }
        var request = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        request.httpMethod = "GET"
        let session = URLSession(configuration: config)
        let decoder = JSONDecoder()
        var answers: [StackOFAnswers] = []
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data) as? Dictionary<String, AnyObject> {
                        print(json)
                        if let items = json["items"] {
                            
                        }
                    }
                }
                
               
            }
        }
        task.resume()
    }
}



//{
//  "owner": {
//    "reputation": 9001,
//    "user_id": 1,
//    "user_type": "registered",
//    "accept_rate": 55,
//    "profile_image": "https://www.gravatar.com/avatar/a007be5a61f6aa8f3e85ae2fc18dd66e?d=identicon&r=PG",
//    "display_name": "Example User",
//    "link": "http://example.stackexchange.com/users/1/example-user"
//  },
//  "down_vote_count": 2,
//  "up_vote_count": 3,
//  "is_accepted": false,
//  "score": 1,
//  "last_activity_date": 1600785570,
//  "last_edit_date": 1600810770,
//  "creation_date": 1600742370,
//  "answer_id": 5678,
//  "question_id": 1234,
//  "link": "http://example.stackexchange.com/questions/1234/an-example-post-title/5678#5678",
//  "title": "An example post title",
//  "body": "An example post body"
//}
