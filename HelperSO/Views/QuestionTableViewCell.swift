//
//  QuestionTableViewCell.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell, ConfigurableCell, NibLoadableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var answersTitleLabel: UILabel!
    @IBOutlet weak var answersCounterLabel: UILabel!
    
    func configure(_ item: Question, at indexPath: IndexPath) {
        selectionStyle = .none
        
        //Names
        scoreTitleLabel.text = "score:"
        answersTitleLabel.text = "answers:"
        
        //Values
        titleLabel.text = item.title
        scoreLabel.text = String(item.score)
        answersCounterLabel.text = String(item.answerCount)
    }
}
