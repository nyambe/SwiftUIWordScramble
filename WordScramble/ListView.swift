//
//  ListView.swift
//  WordScramble
//
//  Created by Samuel Ebuka on 1/1/22.
//

import SwiftUI

struct ListView: View {
    let people = ["Zipi", "Zape", "Mortadelo", "Filemón"]
    var body: some View {
        List(people, id: \.self){
            Text($0)
        }
//        List(1..<5){
//            Text("Lista \($0)/4")
//        }
//        List {
//            Text("Fila uno")
//            Text("Fila 2")
//            Section("Seccion"){
//                ForEach(0..<3){
//                    Text("este es \($0)")
//                }
//            }
//            Section("Otra sección"){
//                Text("Queso")
//                Text("Patatas")
//            }
//        }
//        .listStyle(.automatic)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
