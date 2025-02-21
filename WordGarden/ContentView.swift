//
//  ContentView.swift
//  WordGarden
//
//  Created by Robert Beachill on 13/02/2025.
//

import SwiftUI

struct ContentView: View {
    private static let maximumGuesses = 8 // Need to refer to this as Self.maximumGuesses (cos it's a type property)
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var currentWordIndex = 0
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var lettersGuessed = ""
    @State private var guessesRemaining = maximumGuesses
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @FocusState private var textFieldIsFocused: Bool
    private let wordsToGuess = ["SWIFT", "DOG", "CAT"] // All Caps
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Words Guessed: \(wordsGuessed)")
                    Text("Words Missed: \(wordsMissed)")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Words to Guess: \(wordsToGuess.count - (wordsGuessed + wordsMissed))")
                    Text("Words in Game: \(wordsToGuess.count)")
                }
            }
            .padding(.horizontal)
//                        .border(Color.gray)
            
            Spacer()
            
            Text(gameStatusMessage)
                .font(.title)
                .multilineTextAlignment(.center)
                .frame(height: 80)
                .minimumScaleFactor(0.5)
                .padding()
//                            .border(Color.gray)
            
            //TODO: Switch to wordsToGuess[currentWord]
            Text(revealedWord)
                .font(.title)
            
            if playAgainHidden {
                
                HStack {
                    TextField("", text: $guessedLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 2)
                        }
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) {
                            guessedLetter = guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else {
                                return
                            }
                            guessedLetter = String(lastChar).uppercased()
                        }
                        .focused($textFieldIsFocused)
                        .onSubmit {
                            guard guessedLetter != "" else {
                                return
                            }
                            guessALetter()
                            updateGamePLay()
                        }
                    
                    Button("Guess a Letter:") {
                        guessALetter()
                        updateGamePLay()
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedLetter.isEmpty)
                }
            } else {
                Button("Another Word?") {
                    //TODO: Another Word Button action here
                }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            }
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            wordToGuess = wordsToGuess[currentWordIndex]
            // CREATE A STRING FROM A REPEATING VALUE
            revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
        }
        //        .border(Color.gray)
    }
    
    func guessALetter() {
        textFieldIsFocused = false
        lettersGuessed += guessedLetter
        revealedWord = wordToGuess.map {letter in lettersGuessed.contains(letter) ? "\(letter)" : "_"}.joined(separator: " ")
    }
    
    func updateGamePLay() {
        if !wordToGuess.contains(guessedLetter) {
            guessesRemaining -= 1
            imageName = "flower\(guessesRemaining)"
        }
        // When Do We PLay Another Word?
        if !revealedWord.contains("_") {
            gameStatusMessage = "You Guessed It! It Took You \(lettersGuessed.count) Guesses to Guess the Word"
            wordsGuessed += 1
            currentWordIndex += 1
            playAgainHidden = false
        } else if guessesRemaining == 0 {
            gameStatusMessage = "So Sorry, You're All Out of Guesses"
            wordsMissed += 1
            currentWordIndex += 1
            playAgainHidden = false
        } else {
            //TODO: Redo this with LocalisedStringKey & Inflect
            gameStatusMessage = "You've Made \(lettersGuessed.count) Guess\(lettersGuessed.count == 1 ? "" : "es")"
        }
        guessedLetter = ""
    }
}

#Preview {
    ContentView()
}
