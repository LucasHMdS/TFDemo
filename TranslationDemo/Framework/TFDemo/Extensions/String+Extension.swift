//
//  String+Extension.swift
//  TranslationFramework
//
//  Created by Lucas Henrique Machado Da Silva on 29/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import Foundation

extension String {
    mutating func translate() {
        if let newString = TF.shared.getTranslation(forKey: self) {
            self = newString
        } else if let newString = TF.shared.getTranslation(fromTranslation: self) {
            self = newString
        }
    }
}
