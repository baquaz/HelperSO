//
//  AnswersViewModel.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation

class AnswersViewModel {
    
    //MARK: Closures
    var reloadTableClosure: (() -> ())?
    
    var answers = [Answer]() {
        didSet {
            reloadTableClosure?()
        }
    }
    
    func prepareAnswers(from json: [[String:Any]]) {
        var newAnswers = [Answer]()
        for item in json {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: item, options: .prettyPrinted)
                let requestString = String(data: jsonData, encoding: .utf8)
                let data = requestString?.data(using: .utf8)
                
                let jsonDecoder = JSONDecoder()
                let answer = try jsonDecoder.decode(Answer.self, from: data!)
                newAnswers.append(answer)
            }
            catch let error {
                print(error)
            }
        }

        newAnswers = newAnswers.map { (answer) -> Answer in
            var updatedAnswer = answer
            if let body = answer.body {
                let htmlData = NSString(string: body).data(using: String.Encoding.unicode.rawValue)
                let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                updatedAnswer.bodyAttributedString = attributedString
            }
            
            updatedAnswer.creationDateString = Utils.getDateStringFromTimeStamp(timeStamp: Double(answer.creationDate))
            return updatedAnswer
        }
        answers = newAnswers
    }
}
