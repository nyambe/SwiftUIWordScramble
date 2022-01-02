//
//  WorkingWithString.swift
//  WordScramble
//
//  Created by Samuel Ebuka on 1/1/22.
//

import SwiftUI

struct WorkingWithString: View {

    
    @State var correcto: Bool = false
    @State var errorEn: Int = 0
    
    var body: some View {
        List {
            Text("pulsa")
                .onTapGesture {
                    test()
            }
            if correcto {
                Text("correcto")
            } else {
                Text("incorrecto en \(errorEn) ")
            }
        }
    }
    
    func test(){
        let word = "Pan con queso de jamón de culo"
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "es")
        
        let allGood = misspelledRange.location == NSNotFound
        
        errorEn = misspelledRange.location
        
        correcto = allGood
        
        print(allGood)
    //    let input = """
    //a
    //b
    //c
    //"""
    //    let letters = input.components(separatedBy: "\n")
    //    let letter = letters.randomElement()
    //
    //    let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}



struct WorkingWithString_Previews: PreviewProvider {
    static var previews: some View {
        WorkingWithString()
    }
}
