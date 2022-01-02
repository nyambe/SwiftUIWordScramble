//
//  ContentView.swift
//  WordScramble
//
//  Created by Samuel Ebuka on 1/1/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
 
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var points = 0
    
    var body: some View {
        VStack {

            NavigationView {
                List {
                    Section {
                        TextField("Enter you word", text: $newWord)
                            .autocapitalization(.none)
                    }


                    Section {
                        ForEach(usedWords, id:\.self) { word in
                            HStack{
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                    
                    if points > 0 {
                        HStack{
                            
                            Image(systemName: "\(points).circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.green)
                    
                            Text("total points")
                                
                        }
                        .font(.subheadline)
                        
                    }
                    
                }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("Ok", role: .cancel) { }
                } message: {
                    Text(errorMessage)
                }
            }
        }
       

    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more orignal")
            return
        }
        
        guard isPosible(word: answer) else {
            wordError(title: "Word not valid ", message: "You cant spell '\(answer)' word from '\(rootWord)'")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "'\(answer)' not recognized", message: "You can't make up words")
            return
        }
        
        withAnimation {
            points += answer.count
            usedWords.insert(answer, at: 0)
            newWord = ""
        }
        // more validatioin
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPosible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
