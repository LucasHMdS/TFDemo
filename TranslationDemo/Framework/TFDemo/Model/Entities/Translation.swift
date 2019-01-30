//
//  Translation.swift
//  TranslationFramework
//
//  Created by Lucas Henrique Machado Da Silva on 29/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import Foundation

struct Translation: Codable {
    let language: Int
    let value: String
    
    init(language: Int, value: String) {
        self.language = language
        self.value = value
    }
}
