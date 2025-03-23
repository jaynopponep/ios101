//
//  WordGenerator.swift
//  Wordle
//
//  Created by Mari Batilando on 2/20/23.
//

import Foundation

class WordGenerator {
  // Exercise 8: Add more possible words and return a **random** string every time `generateRandomWord` is called
  // Tip: Look at the Array API documentation to see what method returns a random element
  static let possibleWords = ["AUDIO", "GOOZE", "MOUSE", "AGAVE", "GUAVA", "POUND", "SLEEP"]
  static func generateRandomWord() -> String? {
      let randomWord = possibleWords.randomElement()!
      print(randomWord)
      return randomWord
  }
}

