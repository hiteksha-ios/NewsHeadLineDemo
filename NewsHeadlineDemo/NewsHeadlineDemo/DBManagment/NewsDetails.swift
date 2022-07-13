//
//  NewsDetails.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import RealmSwift
// MARK: - DemoElement

class NewsDetails : Object {
    override init() {
        super.init()
    }
    override static func primaryKey() -> String? {
        return "id"
    }
     
    init(author: String,urlToImage: String,content: String,title: String,publishedAt: String,description: String,url: String) {
        self.author = author
        self.urlToImage = urlToImage
        self.content = content
        self.title = title
        self.publishedAt = publishedAt
        self.articleDescription = description
        self.articleUrl = url
        self.id = title
    }
    
    @objc dynamic var author : String = ""
    @objc dynamic var urlToImage: String  = ""
    @objc dynamic var content: String = ""
    @objc dynamic var title : String  = ""
    @objc dynamic var publishedAt : String  = ""
    @objc dynamic var articleDescription : String = ""
    @objc dynamic var articleUrl: String = ""
    @objc dynamic var id: String = ""
    
}

class NewsSources : Object {
    override init() {
        super.init()
    }
    override static func primaryKey() -> String? {
        return "id"
    }
     
    init(sourceId: String,name: String) {
        self.sourceId = sourceId
        self.name = name
        self.id = sourceId
    }
    
    @objc dynamic var sourceId : String = ""
    @objc dynamic var name: String  = ""
    @objc dynamic var id: String = ""
    
}
