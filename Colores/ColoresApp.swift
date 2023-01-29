//
//  ColoresApp.swift
//  Colores
//
//  Created by alumno on 16/11/22.
//

import SwiftUI

@main
struct ColoresApp: App {
    static var winners = [User]()
    var body: some Scene {
        WindowGroup {
            ContentView(rTarget: 0, gTarget: 0, bTarget: 0,rGuess: 0.5, gGuess: 0.5, bGuess: 0.5,  showAlert: false)
        }
    }
}

