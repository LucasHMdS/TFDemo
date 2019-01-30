//
//  Language.swift
//  TranslationFramework
//
//  Created by Lucas Henrique Machado Da Silva on 29/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import Foundation

struct Language: Codable {
    let id: Int
    let iso639: String
    let name: String
}
