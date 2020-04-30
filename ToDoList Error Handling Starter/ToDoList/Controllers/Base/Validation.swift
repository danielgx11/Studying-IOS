//
//  Validation.swift
//  ToDoList
//
//  Created by Daniel Gx on 30/04/20.
//  Copyright © 2020 Gwinyai Nyatsoka. All rights reserved.
//

import Foundation

enum ValidationError: Error {
    case isEmpty
    case isShort
    case isLong
}

class Validation {
    func validate(text: String?, minLenght: Int, maxLenght: Int) throws -> String {
        guard let text = text, !text.isEmpty else { throw ValidationError.isEmpty }
        
        if text.count < minLenght {
            throw ValidationError.isShort
        } else if text.count > maxLenght {
            throw ValidationError.isLong
        }
        
        return text
    }
}
