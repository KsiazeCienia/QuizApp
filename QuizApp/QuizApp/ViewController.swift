//
//  ViewController.swift
//  QuizApp
//
//  Created by Marcin on 04.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var prizeImage: UIImageView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    var currentQuestion:Question?
    
    var numberOfCorrectAnswers = 0
    
    let model = QuizModel()
    var questions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prizeImage.isHidden = true
        
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
                answerButton.setNumberLabel(answerNumber: i + 1)
                
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
                numberOfCorrectAnswers += 1
                
                resultView.backgroundColor = UIColor(red: 72/255, green: 161/255, blue: 49/255, alpha: 0.5)
                resultButton.backgroundColor = UIColor(red: 7/255, green: 56/255, blue: 16/255, alpha: 0.5)
            } else {
               // user got it wrong            
                resultLabel.text = "Słabiutko"
            
                resultView.backgroundColor = UIColor(red: 161/255, green: 44/255, blue: 36/255, alpha: 0.5)
                resultButton.backgroundColor = UIColor(red: 56/255, green: 19/255, blue: 16/255, alpha: 0.5)
            }
            
            resultButton.setTitle("Następne pytanie", for: .normal)
            
            
            
            //MARK:-TODO feedback
            feedbackLabel.text = ""
            dimView.alpha = 1
        }
    }
    
    @IBAction func resultButtonTapped(_ sender: Any) {
        
        // Remove answer buttons of previous question
        for view in answersStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        let currentTitle = resultButton.title(for: .normal)
        
        if let actualTitle = currentTitle {
            if actualTitle == "A może by tak jeszcz raz?" {
                
                currentQuestion = questions[0]
                numberOfCorrectAnswers = 0
                displayCurrentQuestion()
                prizeImage.isHidden = true
                dimView.alpha = 0
                
                return
            }
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
                // display the restults
                displayResults()
            }
            
        }
    }
    
    func displayResults() {
        
        prizeImage.isHidden = false
        
        if (numberOfCorrectAnswers == 10) {
            let aspectConstraint = NSLayoutConstraint(item: prizeImage, attribute: .height, relatedBy: .equal, toItem: prizeImage, attribute: .width, multiplier: 878/1204, constant: 0)
            prizeImage.addConstraint(aspectConstraint)
            resultLabel.text = "W cipe!"
            prizeImage.image = UIImage(named: "prize2")
        } else if(numberOfCorrectAnswers > 5) {
            
            let aspectConstraint = NSLayoutConstraint(item: prizeImage, attribute: .height, relatedBy: .equal, toItem: prizeImage, attribute: .width, multiplier: 3024/4032, constant: 0)
            prizeImage.addConstraint(aspectConstraint)
            resultLabel.text = "Wporząsiu"
            prizeImage.image = UIImage(named: "wporzasiu")
        } else {
            let aspectConstraint = NSLayoutConstraint(item: prizeImage, attribute: .height, relatedBy: .equal, toItem: prizeImage, attribute: .width, multiplier: 3024/4032, constant: 0)
            prizeImage.addConstraint(aspectConstraint)
            resultLabel.text = "Idź precz gorolu!"
            prizeImage.image = UIImage(named:"slabo")
        }
        feedbackLabel.text = "Twój wynik to \(numberOfCorrectAnswers) na \(questions.count)"
        resultButton.setTitle("A może by tak jeszcz raz?", for: .normal)
        
        resultView.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 0.5)
        resultButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        
        dimView.alpha = 1
    }
}

