//
//  UINavigationItem+Extension.swift
//  TranslationDemo
//
//  Created by Lucas Henrique Machado Da Silva on 30/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import UIKit

extension UINavigationItem {
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
        guard let title = self.title, title != "" else {
            return
        }
        
        if (self.key == nil) {
            self.key = title
        }
        
        guard let key = self.key else {
            return
        }
        
        if let newTitle = TF.shared.getTranslation(forKey: key) {
            self.title = newTitle
        } else if let newTitle = TF.shared.getTranslation(fromTranslation: title) {
            self.title = newTitle
        }
    }
}
