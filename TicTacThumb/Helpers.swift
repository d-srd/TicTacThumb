//
//  Helpers.swift
//  TicTacThumb
//
//  Created by Dino Srdoč on 23/01/2018.
//  Copyright © 2018 Dino Srdoč. All rights reserved.
//

import Foundation

// https://stackoverflow.com/a/32922962
public func transpose<T>(input: [[T]]) -> [[T]] {
    if input.isEmpty { return [[T]]() }
    let count = input[0].count
    var out = [[T]](repeating: [T](), count: count)
    for outer in input {
        for (index, inner) in outer.enumerated() {
            out[index].append(inner)
        }
    }
    
    return out
}
