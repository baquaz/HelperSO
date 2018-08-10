//
//  ViewController.swift
//  HelperSO
//
//  Created by Piotr Błachewicz on 09.08.2018.
//  Copyright © 2018 Piotr Błachewicz. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var questionsDataSource: QuestionsDataSource?
    
    //MARK: Constants
    private struct Constants {
        static let title = "SEARCH"
        static let searchPlaceholder = "Search your topic"
        static let tableRowHeigh: CGFloat = 110.0
    }
    
    //MARK: View Model
    lazy var questionsViewModel: QuestionsViewModel = {
       return QuestionsViewModel()
    }()
    
    //MARK: - Lifetime
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup
    func setup() {
        setUpAppearance()
        searchBar.delegate = self
        setUpTableView()
        initData()
    }
    
    func setUpAppearance() {
        title = Constants.title
        searchBar.placeholder = Constants.searchPlaceholder
        DesignManager.addGradientBackground(on: view)
        tableView.backgroundColor = UIColor.clear
    }
    
    func setUpTableView() {
        tableView.register(QuestionTableViewCell.self)
        tableView.rowHeight = Constants.tableRowHeigh
        
        questionsViewModel.reloadTableClosure = {
            self.questionsDataSource?.provider.items = [self.questionsViewModel.questions]
            self.tableView.reloadData()
        }
    }
    
    func initData()  {
        questionsDataSource = QuestionsDataSource(tableView: tableView, array: questionsViewModel.questions)
        questionsDataSource?.tableItemSelectionHandler = { [unowned self] (indexPath) in
            print("Did select: \(indexPath.row)")
        }
    }
    
    //MARK: - Search
    func search(for query: String?) {
        guard let query = query else {
            //<#MARK: TODO - popup error#>
            print("Error: no query")
            return
        }
        guard query.count > 0  else {
            //<#MARK: TODO - popup error#>
            questionsViewModel.questions.removeAll()
            return
        }
        
        Spinner.showActivityIndicator(on: view)
        NetworkManager.shared.getSearch(for: query, success: { [unowned self] (items) in
            Spinner.stop()
            self.questionsViewModel.prepareQuestions(from: items)
        }) { (errorCode, message) in
            Spinner.stop()
            //<#MARK: TODO - popup error#>
            print("Error: \(message)")
        }
    }
}

//MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        search(for: searchBar.text)
    }
}

