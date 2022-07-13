//
//  RealmHelper.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}


private let fileURL = FileManager.default
    .containerURL(forSecurityApplicationGroupIdentifier: Config.groupName)!
    .appendingPathComponent("default.realm")

private let config = RealmConfig.getConfig(fileURL: fileURL)
let appRealm = try! Realm(configuration: config)

class RealmHelper {
    
    typealias Transaction = () -> Void
    private var uiRealm: Realm!
    
    class var shared : RealmHelper {
        struct Static {
            static let instance : RealmHelper = RealmHelper()
        }
        return Static.instance
    }
    init() {
        uiRealm = appRealm
    }
    
    
    func saveObjectToRealm(object: Object, update: Bool = true) {
        
        openTransaction {
            if update {
                uiRealm.add(object, update: .modified)
            } else {
                uiRealm.add(object)
            }
        }
    }
    
    func saveObjectToRealmSafely(object: Object, update: Bool = true) {
        
        try! uiRealm.safeWrite {
            if update {
                uiRealm.add(object, update: .modified)
            } else {
                uiRealm.add(object)
            }
        }
    }
    func deleteObjectFromRealm(object: Object) {
        openTransaction {
          uiRealm.delete(object)
        }
    }
    
    
    
    func getAllFlightObjects() -> Results<NewsDetails> {
        return uiRealm.objects(NewsDetails.self)
    }
    
    private func openTransaction(transaction: Transaction) {
        try! uiRealm.write {
            transaction()
        }
    }
    
    
}
extension Results {
    func toArray() -> [Element] {
      return compactMap {
        $0
      }
    }
 }
