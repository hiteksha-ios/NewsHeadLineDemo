//
//  Config.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import UIKit
class Config {
    
    static let appName = "NewsHeadlineDemo"
    
    
    static let bundleName = "com.test.NewsHeadlineDemo"
    static let groupName = "group.\(bundleName)"
    private static let teamId = ""
    
    private static let shareURLScheme = ""
    static let shareUrl = "\(shareURLScheme)://dataUrl=Share"
    static let groupHostLink = ""
    
    private static let appId = ""// you can get it from AppStore Connect
    static let appLink = "https://apps.apple.com/app/id\(appId)"
    static let sharedKeychainName = "\(teamId).\(bundleName).\(groupName)"
    static let privacyPolicyLink = ""
    
    
    
    //About
    static let twitter = ""
    static let website = ""
    static let email = ""
    
}
