//
//  ButtonCalculation.swift
//  CalculationGame
//
//  Created by Huy Than Duc on 30/11/2020.
//

import Foundation

class ButtonCalculation {
    let value : String
    let image : String
    init(value:String,image: String) {
        self.value = value
        self.image = image
    }
    deinit {
        print("Deinit KeyBoard ")
    }
}
