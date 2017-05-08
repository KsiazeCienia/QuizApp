//
//  AnswerButton.swift
//  QuizApp
//
//  Created by Marcin on 05.05.2017.
//  Copyright © 2017 Marcin Włoczko. All rights reserved.
//

import UIKit

class AnswerButton: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var numberStackView = UIStackView()
    var answerStackView = UIStackView()
    
    var numberLabel = UILabel()
    var answerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        
        answerStackView.addArrangedSubview(answerLabel)
        answerStackView.alignment = .center
        self.addArrangedSubview(answerStackView)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnswerLabel(answerText: String) {
        answerLabel.textAlignment = .center
        answerLabel.text = answerText
    }

}
