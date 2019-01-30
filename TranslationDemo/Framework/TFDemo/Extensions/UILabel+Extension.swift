//
//  UILabel+Extension.swift
//  TranslationFramework
//
//  Created by Lucas Henrique Machado Da Silva on 29/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import UIKit

extension UILabel {
    private struct Holder {
        static var keys = [String: String?]()
    }
    
    var key: String? {
        get {
            guard let holderKey = Holder.keys[self.debugDescription] else {
                return nil
            }
            
            return holderKey
        }
        set {
            Holder.keys[self.debugDescription] = newValue
        }
    }
    
    func translate() {
        guard let text = self.text, text != "" else {
            return
        }
        
        if (self.key == nil) {
            self.key = text
        }
        
        guard let key = self.key else {
            return
        }
        
        if let newText = TF.shared.getTranslation(forKey: key) {
            self.text = newText
        } else if let newText = TF.shared.getTranslation(fromTranslation: text) {
            self.text = newText
        }
    }
}
