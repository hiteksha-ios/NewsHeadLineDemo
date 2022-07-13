//
//  ResponseModel.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import UIKit
// MARK: - DemoElement
struct NewsHeadLineResponse : Codable {
    let status : String?
    let articles : [NewsArticles]?
    let totalResults : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case articles = "articles"
        case totalResults = "totalResults"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        articles = try values.decodeIfPresent([NewsArticles].self, forKey: .articles)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }

}
struct NewsArticles : Codable {
    let source : Source?
    let author : String?
    let urlToImage : String?
    let content : String?
    let title : String?
    let publishedAt : String?
    let description : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case source = "source"
        case author = "author"
        case urlToImage = "urlToImage"
        case content = "content"
        case title = "title"
        case publishedAt = "publishedAt"
        case description = "description"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source = try values.decodeIfPresent(Source.self, forKey: .source)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}


struct Source : Codable {
    let id : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
