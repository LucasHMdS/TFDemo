//
//  LanguageViewController.swift
//  TranslationDemo
//
//  Created by Lucas Henrique Machado Da Silva on 29/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.loadTFDemo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (TF.shared.translations != nil) {
            self.translate()
        }
    }
}

// MARK: - Setups
extension LanguageViewController {
    func setupTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - TFDemo
extension LanguageViewController {
    func loadTFDemo() {
        TF.shared.load {
            [weak self] (success) in
            guard let `self` = self else { return }
            
            if (success) {
                self.reloadOnMain()
            } else {
                self.errorOnMain()
            }
        }
    }
    
    func reloadOnMain() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorOnMain() {
        DispatchQueue.main.async {
            self.displayError(withMessage: "Failed to load translation files!", defaultButton: "Try again", handler: {
                (action) in
                
                switch (action.style) {
                    case .destructive:
                        break
                    case .cancel:
                        break
                    case .default:
                        self.loadTFDemo()
                }
            })
        }
    }
}

// MARK: - Translated objects
extension LanguageViewController {
    func translate() {
        self.navigationItem.translate()
    }
}


// MARK: - TableView Delegate
extension LanguageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let languages = TF.shared.languages else { return }
        TF.shared.selectedLanguage = languages[indexPath.row].id
        self.performSegue(withIdentifier: "languageToMain", sender: tableView)
    }
}

// MARK: - TableView DataSource
extension LanguageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TF.shared.languages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let languages = TF.shared.languages else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as? LanguageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.lName.text = languages[indexPath.row].name
        
        return cell
    }
}
