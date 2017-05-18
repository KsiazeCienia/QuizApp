//
//  AnswerButton.swift
//  QuizApp
//
//  Created by Marcin on 05.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

final class AnswerButton: UIStackView {

     //MARK:- Variables
    private var numberStackView = UIStackView()
    private var answerStackView = UIStackView()
    private var numberLabel = UILabel()
    private var answerLabel = UILabel()
    
    //MARK:- Initializaion
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        
        numberLabel.textAlignment = .center
        numberLabel.textColor = .white
        numberLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let numberLabelHeight = NSLayoutConstraint(item: numberLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        numberLabel.addConstraint(numberLabelHeight)
        
        //initialize yhe number label and stackview
        numberStackView.addArrangedSubview(numberLabel)
        numberStackView.alignment = .center
        self.addArrangedSubview(numberStackView)
        
        let widthConstraint = NSLayoutConstraint(item: numberStackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        numberStackView.addConstraint(widthConstraint)
        
        answerLabel.textAlignment = .center
        answerLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        answerLabel.textColor = UIColor.white
        answerLabel.numberOfLines = 0
        
        let answerLabelHeight = NSLayoutConstraint(item: answerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        answerLabel.addConstraint(answerLabelHeight)
        
        //initializae answer label and stackview
        answerStackView.addArrangedSubview(answerLabel)
        answerStackView.alignment = .center
        self.addArrangedSubview(answerStackView)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnswerLabel(answerText: String) {
        answerLabel.text = answerText
    }
    
    func setNumberLabel(answerNumber:Int) {
        numberLabel.text = String(answerNumber)
    }

}
