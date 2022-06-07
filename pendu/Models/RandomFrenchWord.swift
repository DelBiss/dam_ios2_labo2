//
//  QuestionManager.swift
//  pendu
//
//  Created by Philippe Allard-Rousse (Étudiant) on 2022-06-04.
//

import Foundation
class RandomFrenchWord {
    private let url = URL(string: "https://frenchwordsapi.herokuapp.com/api/Word/GetRandomWord?nbrWordsNeeded=1")!

    static let shared = RandomFrenchWord()
    private init() {}


    func get(completionHandler: @escaping (String) -> ()) {
        let task = URLSession.shared.dataTask(with: self.url) { (data, response, error) in
            guard error == nil else {
                completionHandler("Not Found")
                return
            }
            DispatchQueue.main.async {
                completionHandler(self.parse(data: data))
            }
        }
        task.resume()
    }

    private func parse(data: Data?) -> String {
        guard let data = data,
            let serializedJson = try? JSONSerialization.jsonObject(with: data, options: []),
            let parsedJson = serializedJson as? [[String: Any]],
            let results = parsedJson[0]["WordName"] as? String else {
                return "Not Found"
        }
        return results
    }

    
}

