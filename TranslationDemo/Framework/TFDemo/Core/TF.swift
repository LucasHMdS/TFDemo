//
//  TF.swift
//  TranslationFramework
//
//  Created by Lucas Henrique Machado Da Silva on 29/01/19.
//  Copyright © 2019 LucasHMdS. All rights reserved.
//

import Foundation

class TF {
    static let shared = TF()
    
    // MARK: - PUBLIC
    var languages: [Language]?
    var translations: Dictionary<String, [Translation]?>?
    var selectedLanguage: Int = 0
    
    func load(completionHandler: @escaping(Bool) -> Void) {
        self.loadLanguages {
            (successLanguages) in
            
            guard successLanguages else {
                completionHandler(successLanguages)
                return
            }
            
            self.loadTranslations(completionHandler: {
                (successTranslations) in
                
                completionHandler(successLanguages)
            })
        }
    }
    
    func getTranslation(forKey key: String) -> String? {
        guard let translations = self.translations?[key] else {
            return nil
        }
        
        let filteredTranlations = translations?.filter { $0.language == self.selectedLanguage }
        guard let finalTranslations = filteredTranlations, finalTranslations.count > 0 else {
            return nil
        }
        
        return finalTranslations[0].value
    }
    
    
    func getTranslation(fromTranslation translation: String) -> String? {
        guard let databaseDictionary = self.translations else {
            return nil
        }
        
        for key in databaseDictionary.keys {
            guard let translations = databaseDictionary[key] as? [Translation] else {
                continue
            }
            
            let filteredTranlations = translations.filter { $0.value == translation }
            guard filteredTranlations.count > 0 else {
                continue
            }
            
            return getTranslation(forKey: key)
        }
        
        return nil
    }
    
    // MARK: - PRIVATE
    private init() {}
    
    private func loadLanguages(completionHandler: @escaping(Bool) -> Void) {
        TFServices.getLanguageDatabase {
            (languagesDatabase, error) in
            
            guard error == nil else {
                completionHandler(false)
                return
            }
            
            guard let database = languagesDatabase else {
                completionHandler(false)
                return
            }
            
            self.languages = database
            completionHandler(true)
        }
    }
    
    private func loadTranslations(completionHandler: @escaping(Bool) -> Void) {
        TFServices.getStringDatabase {
            (translationsDatabase, error) in
            
            guard error == nil else {
                completionHandler(false)
                return
            }
            
            guard let database = translationsDatabase else {
                completionHandler(false)
                return
            }
            
            self.translations = database
            completionHandler(true)
        }
    }
}
