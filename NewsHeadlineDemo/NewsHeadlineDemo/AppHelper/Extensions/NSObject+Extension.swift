//
//  NEObject+Extension.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation

extension NSObject {
    @objc class var className: String {
        return String(describing: self)
    }

    class var bundle: Bundle {
        return Bundle(for: self)
    }

}
