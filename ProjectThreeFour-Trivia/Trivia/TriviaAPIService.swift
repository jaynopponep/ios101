import Foundation

class TriviaAPIService {
    static func fetchTrivia(amount: Int,
                            category: Int,
                            difficulty: String,
                            type: String,
                            completion: (([TriviaViewController.TriviaQuestion]) -> Void)? = nil) {
        let parameters = "amount=\(amount)&category=\(category)&difficulty=\(difficulty)&type=\(type)"
        guard let fullUrl = URL(string: "https://opentdb.com/api.php?\(parameters)") else {
            assertionFailure("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: fullUrl) { data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response code")
                return
            }

            guard let data = data else {
                assertionFailure("No data received")
                return
            }

            let triviaQuestions = parse(data: data)
            DispatchQueue.main.async {
                completion?(triviaQuestions)
            }
        }
        task.resume()
    }

    private static func parse(data: Data) -> [TriviaViewController.TriviaQuestion] {
        struct APIResponse: Decodable {
            struct QuestionItem: Decodable {
                let question: String
                let correct_answer: String
                let incorrect_answers: [String]
                let category: String
            }
            let results: [QuestionItem]
        }

        do {
            let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            return decodedResponse.results.map { item in
                let allAnswers = (item.incorrect_answers + [item.correct_answer]).shuffled()
                let correctIdx = allAnswers.firstIndex(of: item.correct_answer) ?? 0

                return TriviaViewController.TriviaQuestion(
                    question: item.question,
                    options: allAnswers,
                    correctAnswerIdx: correctIdx,
                    category: item.category
                )
            }
        } catch {
            assertionFailure("Failed to decode JSON: \(error.localizedDescription)")
            return []
        }
    }
}
