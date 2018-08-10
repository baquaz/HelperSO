//
//  QuestionsViewModel.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 09.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation

class QuestionsViewModel: NSObject {
    
    //MARK: Closures
    var reloadTableClosure: (() -> ())?
    
    var questions = [Question]() {
        didSet {
            reloadTableClosure?()
        }
    }
    
    func prepareQuestions(from json: [[String:Any]]) {
        var newQuestions = [Question]()
        for item in json {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                let requestString = String(data: jsonData, encoding: .utf8)
                let data = requestString?.data(using: .utf8)
                
                let jsonDecoder = JSONDecoder()
                let question = try jsonDecoder.decode(Question.self, from: data!)
                newQuestions.append(question)
            }
            catch let error {
                print(error)
            }
        }
        
        newQuestions.sort(by: {$0.score > $1.score} )
        questions = newQuestions
        print("Success decoding")
    }
}
