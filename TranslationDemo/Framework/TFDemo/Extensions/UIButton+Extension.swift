//
//  UIButton+Extension.swift
//  TranslationFramework
//
//  Created by Lucas Henrique Machado Da Silva on 29/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import UIKit

extension UIButton {
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
        guard let title = self.currentTitle ?? self.title(for: self.state), title != "" else {
            return
        }
        
        if (self.key == nil) {
            self.key = title
        }
        
        guard let key = self.key else {
            return
        }
        
        if let newTitle = TF.shared.getTranslation(forKey: key) {
            self.setTitle(newTitle, for: self.state)
        } else if let newTitle = TF.shared.getTranslation(fromTranslation: title) {
                self.setTitle(newTitle, for: self.state)
        }
    }
}
