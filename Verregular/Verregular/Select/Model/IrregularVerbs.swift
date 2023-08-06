//
//  IrregularVerbs.swift
//  IrregularVerbs
//
//  Created by Polina Tereshchenko on 28.07.2023.
//

import Foundation

final class IrregularVerbs {
    
    //Singleton
    static var shared = IrregularVerbs()
    private init() {
        configureVerbs()
    }
    
    // MARK: - Properties
    var selectedVerbs: [Verb] = []
    private(set) var verbs: [Verb] = []
   
    
    private func configureVerbs() {
        verbs = [
            Verb(infinitive: "blow", pastSimple: "blew", participle: "blown"),
            Verb(infinitive: "draw", pastSimple: "drew", participle: "drawn"),
            Verb(infinitive: "eat", pastSimple: "ate", participle: "eaten"),
            Verb(infinitive: "fall", pastSimple: "fell", participle: "fallen"),
            Verb(infinitive: "buy", pastSimple: "bought", participle: "bought"),
            Verb(infinitive: "take", pastSimple: "took", participle: "taken"),
            Verb(infinitive: "bring", pastSimple: "brought", participle: "brought"),
            Verb(infinitive: "make", pastSimple: "made", participle: "made"),
            Verb(infinitive: "cut", pastSimple: "cut", participle: "cut"),
            Verb(infinitive: "feel", pastSimple: "felt", participle: "felt"),
            Verb(infinitive: "break", pastSimple: "broke", participle: "broken"),
            Verb(infinitive: "set", pastSimple: "set", participle: "set"),
        ]
        selectedVerbs = verbs
    }
}
