//
//  ViewController.swift
//  QuizApp
//
//  Created by Marcin on 04.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    var currentQuestion:Question?
    
    let model = QuizModel()
    var questions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dimView.alpha = 0
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
            createAnswerButtons()
        }
    }
    
    func createAnswerButtons() {
        
        if let actualCurrentQuestion = currentQuestion {
        
            for i in 0..<actualCurrentQuestion.answers.count {
                
                let answerButton = AnswerButton()
                answerButton.tag = i
                
                answerButton.setAnswerLabel(answerText: actualCurrentQuestion.answers[i])
                
                let heightConstraint = NSLayoutConstraint(item: answerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
                answerButton.addConstraint(heightConstraint)
                
                // add gestureRecognizer to answerButton
                let gestureRecoginzer = UITapGestureRecognizer(target: self, action: #selector(answerTapped(gestureRecognizer:)))
                
                answerButton.addGestureRecognizer(gestureRecoginzer)
                
                answersStackView.addArrangedSubview(answerButton)
                
            }
        }
    }


    func answerTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        if gestureRecognizer.view as? AnswerButton != nil {
            
            let answerButton = gestureRecognizer.view as! AnswerButton
            
            if (answerButton.tag == currentQuestion?.correctAnswer) {
               // user got it correct
                resultLabel.text = "Dobrze Mordeczko!"
            } else {
               // user got it wrong            
                resultLabel.text = "Słabiutko"
            }
            
            //MARK:-TODO feedback
            feedbackLabel.text = ""
            dimView.alpha = 1
        }
    }
    
    @IBAction func resultButtonTapped(_ sender: Any) {
        
        // Remove answer buttons
        for view in answersStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        let indexOfCurrentQuestion = questions.index(of: currentQuestion!)
        
        if let actualIndex = indexOfCurrentQuestion {
            
            let nextIndex = actualIndex + 1
            
            // change to nextQuestion and display it
            if nextIndex < questions.count {
                
                currentQuestion = questions[nextIndex]
                
                displayCurrentQuestion()
                
                dimView.alpha = 0
            } else {
                
            }
            
        }
    }
}

