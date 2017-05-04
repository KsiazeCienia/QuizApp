//
//  QuizModel.swift
//  QuizApp
//
//  Created by Marcin on 04.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class QuizModel: NSObject {
    
    struct JSONKeys {
        static let questionText = "questionText"
        static let answers = "answers"
        static let correctAnswer = "correctAnswer"
    }
    
    func getQuestions() -> [Question] {
        var questions = [Question]()
        
        let questionArray = getQuestionData()
        
        for dataDict in questionArray {
            let question = Question()
            
            question.questionText = dataDict[JSONKeys.questionText] as? String ?? ""
            question.answers = dataDict[JSONKeys.answers] as? [String] ?? []
            question.correctAnswer = dataDict[JSONKeys.correctAnswer] as? Int ?? 0
            
            questions.append(question)
        }
        
        return questions
    }
    
    // Get data from JSON file
    func getQuestionData() -> [[String:Any]] {
        
        var questionArray = [[String:Any]]()
        
        do {
        
            let bundlePath = Bundle.main.path(forResource: "QuestionData", ofType: "json")
            
            if let actualBundlePath = bundlePath {
                
                let url = URL(fileURLWithPath: actualBundlePath)
                
                let data = try Data(contentsOf: url)
                
                let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]] ?? []
                
                questionArray = array
                
            }
        } catch {
            print(error)
        }
        
        return questionArray
    }
}
