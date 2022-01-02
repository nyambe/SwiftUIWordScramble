//
//  LoadingTextView.swift
//  WordScramble
//
//  Created by Samuel Ebuka on 1/1/22.
//

import SwiftUI

struct LoadingTextView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func loadFile(){
        if let fileUrl = Bundle.main.url(forResource: "fichero", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileUrl){
                print(fileContents)
            }
        }
    }
}

struct LoadingTextView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingTextView()
    }
}
