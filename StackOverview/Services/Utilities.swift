//
//  Utilities.swift
//  StackOverview
//
//  Created by Bonhoffer on 9/23/20.
//

import UIKit

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
    
    static var cache = NSCache<NSString, NSData>()
    
    static func imageForUrl(urlString: String, completionHandler: @escaping(_ image: UIImage?, _ url: String) -> ()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            var data: NSData?
            
            if let dataCache = self.cache.object(forKey: urlString as NSString){
                data = (dataCache) as NSData
                
            }else{
                if (URL(string: urlString) != nil)
                {
                    data = NSData(contentsOf: URL(string: urlString)!)
                    if data != nil {
                        self.cache.setObject(data!, forKey: urlString as NSString)
                    }
                }else{
                    return
                }
            }
            
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async {
                    completionHandler(image, urlString)
                }
                return
            }
            
            let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
                
                if (error != nil) {
                    completionHandler(nil, urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data!)
                    self.cache.setObject(data! as NSData, forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                    return
                }
            })
            downloadTask.resume()
        }
        
    }
}
