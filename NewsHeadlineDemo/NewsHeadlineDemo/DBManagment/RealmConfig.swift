//
//  RealmConfig.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import RealmSwift

class RealmConfig {
    private static let schemaVersion: UInt64 = 0
    
    static func getConfig(fileURL: URL, objectTypes: [Object.Type]? = nil) -> Realm.Configuration {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            fileURL: fileURL,


            schemaVersion: schemaVersion,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
//                if (oldSchemaVersion == 0) {
//                    migration.renameProperty(onType: "Dcirrus", from: "callType", to: "direction")
//                }
            }
            ,deleteRealmIfMigrationNeeded: true
            ,objectTypes: objectTypes

        )
        return config
    }

}

