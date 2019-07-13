//
//  CalculateBases.swift
//  NumberBase_App
//
//  Created by Stewart, Christopher Michael on 7/3/19.
//  Copyright © 2019 Christopher. All rights reserved.
//

import Foundation

class CalculateBases{
    
    let outputChoice = ["Convert to Binary", "Convert to Octal", "Convert to Decimal", "Convert to Hexadecimal", "All Conversions"]
    var inType = 0
    var outType = 0
    
    func binary() -> String{
        return String(inType, radix: 2)
    }//end binary
    
    func octal() -> String{
        return String(inType, radix: 8)
    }//end binary
    
    func decimal() -> String{
        return String(inType, radix: 10)
    }//end binary
    
    func hex() -> String{
        return String(inType, radix: 16)
    }//end binary
    
}//end class
