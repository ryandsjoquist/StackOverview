//
//  DataServices.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/22/20.
//

import Foundation

class DataServices {
    static func loadStackOFAnswers(requestType: StackOverflowRequestType, completionHandler: @escaping ([DataStackOverflowItem]) -> ()) {
        //TODO: make site and type of return, currently answers for stackoverflow an enum to let people search for questions or other things for StackOverflow sibling sites.
        guard let url = URL(string: "https://api.stackexchange.com/2.2/\(requestType.rawValue)?order=desc&sort=activity&site=stackoverflow") else { return }
        var request = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        request.httpMethod = "GET"
        let session = URLSession(configuration: config)
        let decoder = JSONDecoder()
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                if let json = try? decoder.decode(DataStackOverflowResponse.self, from: data) {
                    completionHandler(json.items ?? [])
                }
            }
        }
        task.resume()
    }
}
