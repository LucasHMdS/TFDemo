//
//  MainViewController.swift
//  TranslationDemo
//
//  Created by Lucas Henrique Machado Da Silva on 30/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var lMessage: UILabel!
    @IBOutlet weak var bEnd: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.translate()
    }
    
    // MARK: - Actions
    @IBAction func onTouchEnd(_ sender: Any) {
        self.displayError(withMessage: "You can send suggestions at github.com/LucasHMdS", defaultButton: "Access", cancelButton: "Cancel") {
            (action) in
            switch (action.style) {
                case .default:
                    UIApplication.shared.openURL(URL(string: "https://github.com/LucasHMdS")!)
                case .cancel:
                    break
                case .destructive:
                    break
            }
        }
    }
}

// MARK: - Translated objects
extension MainViewController {
    func translate() {
        self.navigationItem.translate()
        self.lMessage.translate()
        self.bEnd.translate()
    }
}
