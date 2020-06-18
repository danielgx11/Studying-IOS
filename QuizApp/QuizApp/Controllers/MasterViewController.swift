//
//  MasterViewController.swift
//  QuizApp
//
//  Created by Daniel Gx on 13/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var quizImage: UIImageView!
    @IBOutlet var questionLabel: UILabel!
    let quiz = Quiz()
    
    // MARK: - Actions
    
    @IBAction func trueButton(_ sender: Any) {
        let result = quiz.check(answer: true)
        alertController(isCorrect: result)
    }
    @IBAction func falseButton(_ sender: Any) {
        let result = quiz.check(answer: false)
        alertController(isCorrect: result)
    }
    
    // MARK: - Life Cycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestion()
    }
    
    // MARK: - Methods
    
    func setQuestion() {
        let currentQuestion = quiz.getQuestion()
        quizImage.image = currentQuestion.image
        questionLabel.text = currentQuestion.question
    }
    
    func alertController(isCorrect correct: Bool) {
        let title = correct ? "Correct Answer" : "Wrong Answer"
        let message = correct ? "You got the right answer" : "You got the wrong answer"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Next Question", style: .default, handler: { [weak self, weak ac] (action) in
            guard let nextQuestion = self?.quiz.nextQuestion() else { return }
            if nextQuestion {
                self?.setQuestion()
                ac?.dismiss(animated: true, completion: nil)
            } else {
                ac?.dismiss(animated: true, completion: nil)
                self?.showFinalScore()
            }
        }))
        present(ac, animated: true)
    }
    
    func showFinalScore() {
        let ac = UIAlertController(title: "Title Score", message: quiz.getScore() , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self, weak ac] (action) in
            self?.quiz.reset()
            self?.setQuestion()
            ac?.dismiss(animated: true, completion: nil)
        }))
        present(ac, animated: true)
    }
}
