//
//  PersistanseManager.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import RealmSwift
import Alamofire

public class PersistanceStoreManager: NSObject {
    @objc public static let shared: PersistanceStoreManager = {
        let instance = PersistanceStoreManager()
        
        return instance
    }()

    var newsDataRequest: DataRequest!
    func getNewsFeed(isShowIndicator: Bool = false, data:@escaping (()->Void)) {
        newsDataRequest?.cancel()
        newsDataRequest = APIManager.shared.requestGetJSON(url: eAPIURL.fetchTopNewsHeadlines, parameters: [:], isShowIndicator: isShowIndicator, completionHandler: { (result) in
            switch result {
            
            case .success(let dicData):
                if let objResponse = dicData as? [String:Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: objResponse, options: .prettyPrinted)
                        let newsFeedDetails = try JSONDecoder().decode(NewsHeadLineResponse.self, from: jsonData)
                        print("newsFeedDetails count :::\(newsFeedDetails.articles?.count ?? 0)")
                        if let newsArticles = newsFeedDetails.articles, newsArticles.count > 0 {
                            self.saveFlightData(arr: newsArticles)
                        }
                    }catch {
                        print("Unexpected error: \(error).")
                    }
                    data()
                }
                
            case .failure(let error):
                print("API Error ::",error.localizedDescription)
                break
            }
        })
        
    }
    
    
    func saveFlightData(arr: [NewsArticles]){
        let realm = RealmHelper.shared
        for obj in arr {
            let objectFlightDetails = NewsDetails(author: obj.author ?? "", urlToImage: obj.urlToImage ?? "", content: obj.content ?? "", title: obj.title ?? "", publishedAt: obj.publishedAt ?? "", description: obj.description ?? "", url: obj.url ?? "")
            realm.saveObjectToRealm(object: objectFlightDetails, update: true)
        }
    }
}
