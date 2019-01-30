//
//  UIViewController+Extension.swift
//  TranslationDemo
//
//  Created by Lucas Henrique Machado Da Silva on 30/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayError(withMessage message: String, defaultButton: String? = nil, cancelButton: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        var finalMessage = message
        finalMessage.translate()
        
        let alert = UIAlertController(title: nil, message: finalMessage, preferredStyle: .alert)
        
        if let cancel = cancelButton {
            var finalCancel = cancel
            finalCancel.translate()
            
            alert.addAction(UIAlertAction(title: finalCancel, style: .cancel, handler: handler))
        }
        
        if let def = defaultButton {
            var finalDefault = def
            finalDefault.translate()
            
            alert.addAction(UIAlertAction(title: finalDefault, style: .default, handler: handler))
        }
        
        self.present(alert, animated: true)
    }
}
