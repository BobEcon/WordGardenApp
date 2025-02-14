//
//  ContentView.swift
//  WordGarden
//
//  Created by Robert Beachill on 13/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var wordsToGuess = ["SWIFT", "DOG", "CAT"] // All Caps
    @State private var gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var currentWord = 0
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    
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
//            .border(Color.gray)
            
            Spacer()
            
            Text(gameStatusMessage)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
//                .border(Color.gray)
            
            //TODO: Switch to wordsToGuess[currentWord]
            Text("_ _ _ _ _")
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
                    
                    Button("Guess a Letter:") {
                        //TODO: Guess a Letter button action here
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                }
            } else {
                Button("Another Word?") {
                    //TODO: Anotherm Word Button action here
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
//        .border(Color.gray)
    }
}

#Preview {
    ContentView()
}
