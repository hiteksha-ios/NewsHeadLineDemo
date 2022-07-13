//
//  AppEnvirnment.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation

enum eAppEnvironment {
    case development,
    production
}

class AppEnvironment {
    
    static let shared = AppEnvironment()
    var environmentType: eAppEnvironment = .production
    
    func setAppEnvironment(type: eAppEnvironment) {
        environmentType = type
    }
    
}
