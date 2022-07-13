//
//  APIManager.swift
//  NewsHeadlineDemo
//
//  Created by Admin on 7/13/22.
//

import Foundation
import Alamofire

class APIManager {
    
    class var shared : APIManager {
        struct Static {
            static let instance : APIManager = APIManager()
        }
        return Static.instance
    }
    
    func toDictionary(modelObject: Any) -> [String : Any] {
        var dictionary = [String:Any]()
        let otherSelf = Mirror(reflecting: modelObject)
        for child in otherSelf.children {
            if let key = child.label {
                dictionary[key] = child.value
            }
        }
        print("USER_DICTIONARY :: \(dictionary.description)")
        return dictionary
    }
    
    func requestGetJSON(url:eAPIURL,parameters: Parameters, isShowIndicator: Bool = false,completionHandler:@escaping (_ result: Result<Any,Error>) -> Void) -> DataRequest{
        
        let header : HTTPHeaders = []
        
        if isShowLog {
            print("requestURL:\(url.getURL())")
            print()
            print("dictHeader:\(header.description)")
            print("parameter:\(parameters.description)")
            print()
        }
        if isShowIndicator {
            showIndicator()
        }
        return AF.request(url.getURL(), method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: header, interceptor: nil).cURLDescription { description in
//            print("description:\(description)")
        }.responseJSON(queue: DispatchQueue.main, options: JSONSerialization.ReadingOptions.fragmentsAllowed) { (response) in
            if isShowIndicator {
                hideIndicator()
            }
            switch response.result {
            case .success(let finalResponse):
                if let res = finalResponse as? [String : Any] {
                    if isShowLog {
                        print()
                        print("response:\(res.description)")
                        print()
                        
                        if let theJSONData = try?  JSONSerialization.data(
                            withJSONObject: res,
                            options: .prettyPrinted
                        ),
                        let theJSONText = String(data: theJSONData,
                                                 encoding: String.Encoding.ascii) {
                            print("JSON string = \n\(theJSONText)")
                        }
                        
                    }
                    //var statusCode: Int = 0
                    //                    if let statusCodel = res[APIKey.messageCode] as? Int {
                    //                        statusCode = statusCodel
                    //                    }
                    completionHandler(.success(res))
                    
                }
                break
            case .failure(let resError):
                if let data  = response.data {
                    if let responseSting = String(data: data, encoding: String.Encoding.utf8){
                        debugPrint("Response Data  ::",responseSting)
                    }
                }
                
                if let err = resError.underlyingError as? URLError, err.code == URLError.Code.networkConnectionLost {
                    getDelayMainQueue(delay: 0.5) {
                        _ = self.requestGetJSON(url:url,parameters: parameters, isShowIndicator: isShowIndicator,completionHandler:completionHandler)
                    }
                    return
                }else if resError.isExplicitlyCancelledError == true {
                    completionHandler(.failure(resError))
                }else {
                    completionHandler(.failure(resError))
                }
                break
            }
        }
    }
    
}

