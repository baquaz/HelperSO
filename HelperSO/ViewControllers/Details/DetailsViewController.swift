//
//  DetailsViewController.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 10.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var questionTitleLabel: UITextView!
    @IBOutlet weak var questionCreatorLabel: UILabel!
    @IBOutlet weak var questionCreatorTitleLabel: UILabel!
    @IBOutlet weak var questionDateTitleLabel: UILabel!
    @IBOutlet weak var questionDateLabel: UILabel!
    @IBOutlet weak var questionScoreTitleLabel: UILabel!
    @IBOutlet weak var questionScoreLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Constants
    struct Constants {
        static let title = "Question Details"
        static let questionCreatorTitle = "Creator:"
        static let questionDateTitle = "Created at:"
        static let scoreTitle = "Score:"
    }
    
    //MARK: Question
    var question: Question!
    
    //MARK: Data Source
    private var answersDataSource: AnswersDataSource?
    
    //MARK: View Models
    lazy var questionViewModel: QuestionsViewModel = {
        return QuestionsViewModel()
    }()
    lazy var answersViewModel: AnswersViewModel = {
        return AnswersViewModel()
    }()

    //MARK: - Lifetime
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getAnswers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup
    func setup() {
        setUpAppearance()
        setUpQuestionDetails()
        setUpTableView()
        initData()
    }
    
    func setUpAppearance() {
        title = Constants.title
        DesignManager.addGradientBackground(on: view)
    }
    
    func setUpQuestionDetails() {
        //Titles
        questionCreatorTitleLabel.text = Constants.questionCreatorTitle
        questionDateTitleLabel.text = Constants.questionDateTitle
        questionScoreTitleLabel.text = Constants.scoreTitle
        
        //Values
        questionTitleLabel.text = question.title
        questionCreatorLabel.text = question.owner.displayName
        questionDateLabel.text = Utils.getDateStringFromTimeStamp(timeStamp: Double(question.creationDate))
        questionScoreLabel.text = String(question.score)
    }
    
    func setUpTableView() {
        tableView.register(AnswerTableViewCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140.0
        
        answersViewModel.reloadTableClosure = {
            self.answersDataSource?.provider.items = [self.answersViewModel.answers]
            self.tableView.reloadData()
        }
    }
    
    func initData()  {
        answersDataSource = AnswersDataSource(tableView: tableView, array: answersViewModel.answers)
    }
    
    //MARK: - Get Answers
    func getAnswers() {
        Spinner.showActivityIndicator(on: view)
        NetworkManager.shared.getAnswers(for: String(question.questionId), success: { [unowned self] (answersJSON) in
            Spinner.stop()
            self.answersViewModel.prepareAnswers(from: answersJSON)
        }) { (errorCode, message) in
            Spinner.stop()
            //<#MARK: TODO - popup error#>
            print("Error: \(message)")
        }
    }
}
