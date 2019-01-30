//
//  TFServices.swift
//  TranslationDemo
//
//  Created by Lucas Henrique Machado Da Silva on 30/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import Foundation

enum TFServicesError: Error {
    case dataNotFound
}

class TFServices: NSObject {
    private static let baseUrl = "https://my-json-server.typicode.com/LucasHMdS/TFDemo"
    
    static func getLanguageDatabase(completionHandler: @escaping([Language]?, Error?) -> Void) {
        let endpoint = "/languageDatabase"
        CodableNetworking<[Language]>.get(fromURL: URL(string: "\(baseUrl)\(endpoint)")!) {
            (languages, error) in
            
            completionHandler(languages, error)
        }
    }
    
    static func getStringDatabase(completionHandler: @escaping(Dictionary<String, [Translation]?>?, Error?) -> Void) {
        let endpoint = "/stringDatabase"
        CodableNetworking<[StringDatabase]>.get(fromURL: URL(string: "\(baseUrl)\(endpoint)")!) {
            (stringDatabase, error) in
            
            guard error == nil else {
                return
            }
            
            guard let database = stringDatabase else {
                completionHandler(nil, TFServicesError.dataNotFound)
                return
            }
            
            var translations = Dictionary<String, [Translation]?>()
            for entry in database {
                var entryTranslations = [Translation(language: entry.language, value: entry.key)]
                entryTranslations.append(contentsOf: entry.translations)
                
                translations[entry.key] = entryTranslations
            }
            
            completionHandler(translations, nil)
        }
    }
}
