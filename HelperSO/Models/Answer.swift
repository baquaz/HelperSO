//
//  Answer.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation

struct Answer: Codable {
    var owner: AnswerOwner
    let isAccepted: Bool?
    let score: Int
    let answerId: Int
    let questionId: Int
    let creationDate: Int
    var body: String?
    
    //MARK: Custom
    var creationDateString: String?
    var bodyAttributedString: NSAttributedString?
}

extension Answer {
    enum CodingKeys: String, CodingKey {
        case owner
        case isAccepted = "is_accepted"
        case score
        case answerId = "answer_id"
        case questionId = "question_id"
        case creationDate = "creation_date"
        case body
    }
}

struct AnswerOwner: Codable {
    let reputation: Int?
    let userId: Int?
    let userType: String
    let displayName: String
}

extension AnswerOwner {
    enum CodingKeys: String, CodingKey {
        case reputation
        case userId = "user_id"
        case userType = "user_type"
        case displayName = "display_name"
    }
}
