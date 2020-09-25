//
//  DataServices.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/22/20.
//

import Foundation

class NetworkServices {
    
    static let baseSOUrl = "https://api.stackexchange.com/2.2/"
    
    static func loadStackOFRequest(requestResultType: StackOverflowRequestType,
                                   requestResultSite: StackOverflowRequestSite,
                                   requestQuery: String?,
                                   completionHandler: @escaping ([DataStackOverflowItem]) -> ()) {
        //TODO: make site and type of return, currently answers for stackoverflow an enum to let people search for questions or other things for StackOverflow sibling sites.
        var queryString = ""
        if let requestQuery = requestQuery {
            queryString = requestQuery
        } else {
            queryString = "?pagesize=100&order=desc&sort=activity&site="
        }
        guard let url = URL(string: baseSOUrl+requestResultType.rawValue+queryString+requestResultSite.rawValue) else { return }
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
                    DispatchQueue.main.async {
                        completionHandler(json.items ?? [])
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Error in parsing")
                        completionHandler([])
                    }
                }
            }
           
        }
        task.resume()
    }
}
