//
//  APIUrl.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation

var isShowLog: Bool = true

enum eAPIBaseURL: String {
    
    case baseURLLive = "https://newsapi.org/v2/top-headlines"
    case baseURLTesting = ""
    
    static func getBaseURL() -> String {
        switch AppEnvironment.shared.environmentType {
        case .development:
            return eAPIBaseURL.baseURLTesting.rawValue
        case .production:
            return eAPIBaseURL.baseURLLive.rawValue
        }
    }
}

enum eAPIURL {
    case fetchTopNewsHeadlines
    
    func getURL() -> String {
        let baseURL = eAPIBaseURL.getBaseURL()
        
        switch self {
        case .fetchTopNewsHeadlines:
            return baseURL + "?sources=techcrunch&apiKey=af540169d0a442b09395b97d93a96e39"
        }
    }
}

