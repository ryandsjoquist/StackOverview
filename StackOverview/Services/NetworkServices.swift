//
//  DataServices.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/22/20.
//

import Foundation

class NetworkServices {
    
    static let baseSOUrl = "https://api.stackexchange.com/2.2/"
    
    static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    static func loadStackOFAnswers(requestType: StackOverflowRequestType, completionHandler: @escaping ([DataStackOverflowItem]) -> ()) {
        //TODO: make site and type of return, currently answers for stackoverflow an enum to let people search for questions or other things for StackOverflow sibling sites.
        guard let url = URL(string: baseSOUrl+requestType.rawValue+"?order=desc&sort=activity&site=stackoverflow") else { return }
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
                } else {
                    print("Error in parsing")
                    completionHandler([])
                }
            }
        }
        task.resume()
    }
}

