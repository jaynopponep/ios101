import UIKit

class TriviaViewController: UIViewController {
    private var currQuestionIdx = 0
    private var score = 0
    private let questionNumberLabel = UILabel()
    private let categoryLabel = UILabel()
    private let questionLabel = UILabel()
    private let answersStackView = UIStackView()
    
    struct TriviaQuestion {
        let question: String
        let options: [String]
        let correctAnswerIdx: Int
        let category: String
    }
    
    private let questions = [
        TriviaQuestion(
            question: "What was the first weapon pack for 'PAYDAY'?",
            options: ["The Overkill Pack", "The Gage Weapon Pack #1", "The Gage Chivalry Pack", "The Gage Historical Pack"],
            correctAnswerIdx: 1,
            category: "Entertainment: Video Games"
        ),
        TriviaQuestion(
            question: "Which of these founding fathers of the United States of America later became president?",
            options: ["Roger Sherman", "James Monroe", "Samuel Adams", "Alexander Hamilton"],
            correctAnswerIdx: 1,
            category: "History"
        ),
        TriviaQuestion(
            question: "In 2009, what became the first Morse code character to be added since WWII?",
            options: ["#", "A", "@", "*"],
            correctAnswerIdx: 2,
            category: "History"
        ),
    ]
    // standard procedure/lifestyle method
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayQuestion()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
        
        questionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        questionNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        questionNumberLabel.textAlignment = .center
        view.addSubview(questionNumberLabel)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        categoryLabel.textAlignment = .center
        view.addSubview(categoryLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        view.addSubview(questionLabel)
        
        answersStackView.translatesAutoresizingMaskIntoConstraints = false
        answersStackView.axis = .vertical
        answersStackView.spacing = 10
        answersStackView.distribution = .fillEqually
        view.addSubview(answersStackView)
        
        NSLayoutConstraint.activate([
            questionNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: questionNumberLabel.bottomAnchor, constant: 8),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            questionLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            answersStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            answersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answersStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            answersStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    private func displayQuestion() {
        // guard -> make sure that this is true, otherwise
        guard currQuestionIdx < questions.count else {
            quizCompletePopup()
            print("Quiz finished! Score: \(score)/\(questions.count)")
            return
        }
        let currQuestion = questions[currQuestionIdx]
        questionNumberLabel.text = "Question: \(currQuestionIdx)/\(questions.count)"
        categoryLabel.text = currQuestion.category
        questionLabel.text = currQuestion.question
        
        // following clears the answer stack
        answersStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for (i, option) in currQuestion.options.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor(red: 135/255, green: 206/255, blue: 235/255, alpha: 1.0)
            button.layer.cornerRadius = 8
            button.tag = i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.contentHorizontalAlignment = .center
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
            answersStackView.addArrangedSubview(button)
        }
    }
    @objc private func answerButtonTapped(_ sender: UIButton) {
        let selectedAnswerIndex = sender.tag
        let question = questions[currQuestionIdx]
        
        if selectedAnswerIndex == question.correctAnswerIdx {
            score += 1
            sender.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
            if let correctButton = answersStackView.arrangedSubviews[question.correctAnswerIdx] as? UIButton {
                correctButton.backgroundColor = .green
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.currQuestionIdx += 1
            self.displayQuestion()
        }
    }
    private func quizCompletePopup() {
        let alertController = UIAlertController(
            title: "Quiz Complete!",
            message: "Your final score: \(score)/\(questions.count)",
            preferredStyle: .alert
        )
        let restartAction = UIAlertAction(title: "Play Again", style: .default) { [weak self] _ in
            self?.resetQuiz()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true)
    }

    
    private func resetQuiz() {
        currQuestionIdx = 0
        score = 0
        displayQuestion()
    }
}
