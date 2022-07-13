//
//  Utilities.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Utilities : NSObject{
    
}
func showIndicator(){
    getMainQueue {
        let activityData = ActivityData(type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.red)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
}

func hideIndicator(){
    getMainQueue {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

func getMainQueue(completion: @escaping (() -> Void)) {
    DispatchQueue.main.async {
        completion()
    }
}

func getDelayMainQueue(delay: Double, completion: @escaping (() -> Void)) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        completion()
    }
}

