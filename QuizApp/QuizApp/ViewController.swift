//
//  ViewController.swift
//  QuizApp
//
//  Created by Marcin on 04.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestion:Question?
    
    let model = QuizModel()
    var questions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.questions = model.getQuestions()
        
        if (!questions.isEmpty) {
            currentQuestion = questions[0]
            
            displayCurrentQuestion()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCurrentQuestion() {
        
        if let actualCurrentQuestion = currentQuestion {
            
            questionLabel.text = actualCurrentQuestion.questionText
            
            //create answers buttons
            for _ in 0...actualCurrentQuestion.answers.count {
                createAnswerButtons()
            }
        }
    }
    
    func createAnswerButtons() {
        
        if let actualCurrentQuestion = currentQuestion {
        
            for i in 0..<actualCurrentQuestion.answers.count {
                
                let answerButton = AnswerButton()
                
                answerButton.setAnswerLabel(answerText: actualCurrentQuestion.answers[i])
                
                let heightConstraint = NSLayoutConstraint(item: answerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
                answerButton.addConstraint(heightConstraint)
                
                answersStackView.addArrangedSubview(answerButton)
                
            }
        }
    }


}

