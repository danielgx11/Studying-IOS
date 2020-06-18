//
//  Quiz.swift
//  QuizApp
//
//  Created by Daniel Gx on 13/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

struct QuizQuestion {
    var correctAnswer: Bool
    var question: String
    var image: UIImage
}

class Quiz {
    
    // MARK: - Properties
    
    private var questions: [QuizQuestion] = [
        QuizQuestion(correctAnswer: true, question: "Is this a tree?", image: UIImage(named: "tree")!),
        QuizQuestion(correctAnswer: false, question: "Is this a dog?", image: UIImage(named: "car")! ),
        QuizQuestion(correctAnswer: false, question: "Is this a person?", image: UIImage(named: "mug")!)
    ]
    
    private var score: Int = 0
    private var questionIndex: Int = 0
    
    // MARK: - Methods
    
    func getScore() -> String {
        return "\(score) \\ \(questions.count)"
    }
    
    func getQuestion() -> QuizQuestion {
        return questions[questionIndex]
    }
    
    func check(answer: Bool) -> Bool {
        let question = getQuestion()
        
        if question.correctAnswer == answer {
            score += 1
            return true
        }
        
        return false
    }
    
    func nextQuestion() -> Bool {
        questionIndex += 1
        
        switch questionIndex {
            case 0, 1, 2: return true
            default: return false
        }
    }
    
    func reset() {
        questionIndex = 0
        score = 0
    }
}
