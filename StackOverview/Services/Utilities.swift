//
//  Utilities.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/23/20.
//

import Foundation

class Utilities {
    static func convertIntToDate(dateAsInt: Int?) -> String {
        if let dateInt = dateAsInt {
            let date = Date(timeIntervalSince1970: Double(dateInt))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .medium //Set time style
            dateFormatter.dateStyle = .medium //Set date style
            dateFormatter.timeZone = .current
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
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
    
}
