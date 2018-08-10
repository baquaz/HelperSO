//
//  NetworkManager.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 09.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    //MARK: Constants
    let baseURL: String = "https://api.stackexchange.com/2.2/"
    let baseParameters: Parameters = [
        "site" : "stackoverflow"
    ]
    let searchPath: String = "search"
    let questionsPath: String = "questions/"
    let answersPath: String = "answers/"
    
    //MARK: - GET search
    func getSearch(for query: String, success: @escaping ([[String:Any]]) -> (), failure: @escaping (_ statusCode: Int?, _ message: String) -> ())  {
        let url = baseURL + searchPath
        var parameters = baseParameters
        parameters["intitle"] = query
        
        //MARK: <#TODO: - Pagination#>
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let JSON = response.result.value as? [String : Any] {
                        if let questions = JSON["items"] as? [[String:Any]] {
                            success(questions)
                            break
                        }
                    }
                    failure(nil, "Unexpected error: Reading response failed!")
                case .failure(let error):
                    let errorData = self.getErrorData(error, response: response)
                    failure(errorData.statusCode, errorData.message)
                }
        }
    }
    
    //MARK: - GET answers
    func getAnswers(for questionId: String, success: @escaping ([[String:Any]]) -> (), failure: @escaping (_ statusCode: Int?, _ message: String) -> ()) {
        let url = baseURL + questionsPath + "\(questionId)/" + answersPath
        var parameters = baseParameters
        parameters["order"] = "desc"
        parameters["sort"] = "votes"
        parameters["filter"] = "withbody"
        
        //MARK: <#TODO: - Pagination#>
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    if let JSON = response.result.value as? [String : Any] {
                        if let answers = JSON["items"] as? [[String:Any]] {
                            success(answers)
                            break
                        }
                    }
                    failure(nil, "Unexpected error: Reading response failed!")
                case .failure(let error):
                    let errorData = self.getErrorData(error, response: response)
                    failure(errorData.statusCode, errorData.message)
                }
        }
    }
}

//MARK: - Error Parser
extension NetworkManager {
    private func getErrorData(_ error: Error, response : DataResponse<Any>) -> (statusCode: Int, message: String) {
        var statusCode : Int = error._code
        if let code = response.response?.statusCode {
            statusCode = code
        }
        var message: String = error.localizedDescription
        
        if let responseData = response.data {
            let errorData = self.getErrorStatusCodeAndMessageFromResponse(data: responseData)
            if let code = errorData.statusCode{
                statusCode = code
            }
            if let messageData = errorData.message{
                message = messageData
            }
        }
        return (statusCode, message)
    }
    
    private func getErrorStatusCodeAndMessageFromResponse(data: Data!) -> (statusCode: Int?, message: String?) {
        var statusCode : Int?
        var message: String?
        
        do {
            let JSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
            if let codeJSON = JSON!["error_id"] as? Int {
                statusCode = codeJSON
            }
            if let messageJSON = JSON!["error_message"] as? String {
                message = messageJSON
            }
            return (statusCode, message)
        } catch {
            return (nil, nil)
        }
    }
}
