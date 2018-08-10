//
//  AnswerTableViewCell.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell, ConfigurableCell, NibLoadableView {

    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var createdDateTitleLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ item: Answer, at indexPath: IndexPath) {
        selectionStyle = .none
        scoreTitleLabel.text = "Score:"
        createdDateTitleLabel.text = "Created at:"
        
        //Values
        if let bodyAttributed = item.bodyAttributedString {
            bodyTextView.attributedText = bodyAttributed
        } else {
            bodyTextView.text = item.body
        }
        
        createdDateLabel.text = item.creationDateString
        
        creatorLabel.text = item.owner.displayName.stringWithDecodedHTMLChars
        scoreLabel.text = String(item.score)
    }
    
}
