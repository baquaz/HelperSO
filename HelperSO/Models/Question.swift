//
//  Question.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 09.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation

struct Question: Codable {
    var tags: [String]?
    var owner: QuestionOwner
    let isAnswered: Bool
    let viewCount: Int
    let acceptedAnswerId: Int?
    let answerCount: Int
    let score: Int
    let creationDate: Date
    let questionId: Int
    let link: String
    let title: String
}

extension Question {
    enum CodingKeys: String, CodingKey {
        case tags
        case owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case acceptedAnswerId = "accepted_answer_id"
        case answerCount = "answer_count"
        case score
        case creationDate = "creation_date"
        case questionId = "question_id"
        case link
        case title
    }
}

struct QuestionOwner: Codable {
    let reputation: Int?
    let userId: Int?
    let userType: String
    let displayName: String
}

extension QuestionOwner {
    enum CodingKeys: String, CodingKey {
        case reputation
        case userId = "user_id"
        case userType = "user_type"
        case displayName = "display_name"
    }
}


