//
//  Game.swift
//  TicTacThumb
//
//  Created by Dino Srdoč on 23/01/2018.
//  Copyright © 2018 Dino Srdoč. All rights reserved.
//

/// Declare conformance to this protocol to use it in a `Board`
protocol Pieces {
}

/// Holds a Tic-Tac-Toe grid along with some helper methods.
struct TicTacBoard<T: Pieces & Equatable>: CustomStringConvertible {
    private let size: Int
    
    // 2d arrays are easier to use
    private var pieces: [[T?]] {
        didSet { inverse = transpose(input: pieces) }
    }
    // literally pieces, but transposed
    private var inverse: [[T?]]
    
    // the board starts off empty
    init(size: Int) {
        self.size = size
        pieces = Array(repeating: Array(repeating: nil, count: size), count: size)
        inverse = pieces
    }
    
    // y returns row (height), x returns column (width)
    // e.g. [
    //          [a, b, c]
    //          [d, e, f]
    //          [g, h, i]
    //      ]
    // the index of d ^^ is [1, 0]
    subscript(y: Int, x: Int) -> T? {
        get {
            return pieces[y][x]
        }
        set {
            pieces[y][x] = newValue
        }
    }
    
    var rows: [[T?]] {
        return pieces
    }
    
    var cols: [[T?]] {
        return inverse
    }
    
    var diagLeft: [T?] {
        return stride(from: 0, to: size, by: 1).map {
            pieces[$0][$0]
        }
    }
    
    var diagRight: [T?] {
        return stride(from: 0, to: size, by: 1).map {
            pieces[$0][size - ($0+1)]
        }
    }
    
    // board is full if no piece is nil. this is a weird way of calculating that
    var isFull: Bool {
        return !pieces.map {
            !$0.map { $0 != nil }.contains(false)
        }.contains(false)
    }
    
    // a board is "won" if there are 3 consecutive pieces in a row, column, or diagonal.
    // this is a weird way of calculating that.
    func isWon(byPiece piece: T) -> Bool {
        return rows.map { !$0.map { piece == $0 }.contains(false) }.contains(true) ||
            cols.map { !$0.map { piece == $0 }.contains(false) }.contains(true) ||
            !diagLeft.map { piece == $0 }.contains(false) ||
            !diagRight.map { piece == $0 }.contains(false)
    }
    
    mutating func reset() {
        pieces = Array(repeating: Array(repeating: nil, count: size), count: size)
        inverse = pieces
    }
    
    var description: String {
        return pieces.map { return $0
            .map { $0 != nil ? String(describing: $0!) : "_" }
            .joined(separator: " ") }
            .joined(separator: "\n")
    }
}

enum GamePieces: Pieces, CustomStringConvertible {
    case x, o
    
    var description: String {
        switch self {
        case .x: return "x"
        case .o: return "o"
        }
    }
    
    var next: GamePieces {
        switch self {
        case .x: return .o
        case .o: return .x
        }
    }
}
