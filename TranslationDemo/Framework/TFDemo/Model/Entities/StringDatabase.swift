//
//  StringsDatabase.swift
//  TranslationDemo
//
//  Created by Lucas Henrique Machado Da Silva on 29/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import Foundation

struct StringDatabase: Codable {
    var key: String
    var language: Int
    var translations: [Translation]
    
    enum CodingKeys: String, CodingKey {
        case key
        case language
        case translations = "translation"
    }
}
