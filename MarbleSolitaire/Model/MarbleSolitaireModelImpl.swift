//
//  MarbleSolitaireImpl.swift
//  MarbleSolitaire
//
//  Created by Raique Pereira on 10/12/18.
//  Copyright © 2018 Raique Pereira. All rights reserved.
//

import Foundation

public enum SLOT {
    case Unavailable
    case Empty
    case Occupied;
}

public enum Error {
    case invalidSlotSelected
    case illegalArgument(msg : String)
}

class MarbleSolitaireModelImpl : MarbleSolitaireModel {
    

    //Private definitions
    private final let armThickness : Int
    private final var board : [[SLOT]];
    private var marbles : Int;
    
    /**
     * Default Constructor for constructing the model MarbleSolitaire.
     */
    public convenience init(){
        self.init(armThickness: 3, sRow: 3, sCol: 3);
    }
    
    /**
     * Constructs the model MarbleSolitaire.
     *
     * @param sRow the row to place an empty space.
     * @param sCol the col to place an empty space.
     */
    public convenience init(sRow : Int, sCol : Int) {
        self.init(armThickness: 3, sRow: sRow, sCol: sCol);
    }
    
    /**
     * Constructs the model MarbleSolitaire.
     *
     * @param armThickness the arm thickness defined by the amount of marbles in
     *                     the upmost / bottommost row or leftmost / rightmost column.
     */
    public convenience init(armThickness : Int) {
    //Calculating the center of the board for sRow and sCol.
        self.init(armThickness: armThickness, sRow: MarbleSolitaireModelImpl.getBoardCenterFrom(armThickness: armThickness), sCol: MarbleSolitaireModelImpl.getBoardCenterFrom(armThickness: armThickness));
    }
    
    /**
     * Constructs the model MarbleSolitaire.
     *
     * @param armThickness the arm thickness defined by the amount of marbles in
     *                     the upmost / bottommost row or leftmost / rightmost column.
     * @param sRow         the row to place an empty space.
     * @param sCol         the col to place an empty space.
     */
    public init(armThickness : Int, sRow : Int, sCol: Int) {
    //Checking for correct arm thickness
    //Rules are that it has to be greater than or equal to three and
    //must be an odd number.
    //arm thickness of 1 is not permitted since the game is unplayable.
    if (armThickness < 3 || (armThickness % 2) == 0) {
        let msg : String = (armThickness < 3) ? "Arm Thickness is less three" : "Arm Thickness is not odd."
        //throw Error.illegalArgument(msg: msg)
    }
        
    let boardLength : Int = ((armThickness - 1) * 2) + armThickness;
    self.armThickness = armThickness;
        self.board = Array(repeating: Array(repeating: SLOT.Unavailable, count: boardLength), count: boardLength)
    self.marbles = 0
    
    //sRows and sCols cannot be greater than or equal to the length of
    //the board. sRow and sCols cannot be less than zero as well.
        if (!validRowAndCol(row: sRow, col: sCol, boardLength: boardLength)) {
            //throw new IllegalArgumentException("Invalid empty cell position (r,c)");
            
        }
        //Initalizing the board
        for row in 0..<self.board.count {
            for col in 0..<self.board.count {
                if ((col < armThickness - 1 || col > boardLength - armThickness)
                    && (row < armThickness - 1 || row > boardLength - armThickness)) {
                    self.board[row][col] = SLOT.Unavailable;
                } else {
                    self.board[row][col] = SLOT.Occupied;
                    self.marbles += 1;
                }
                
            }
        }

    //Is the slot available, if not then throw exception.
    if (self.board[sRow][sCol] == SLOT.Unavailable) {
        //throw new IllegalArgumentException("Invalid empty cell position (r,c)");
    }
    
    self.board[sRow][sCol] = SLOT.Empty;
    self.marbles -= 1;
    }
    
    /**
     * Constructs the model MarbleSolitaire.
     *
     * @param board the board of the game.
     */
    
    public func move(fromRow : Int, fromCol : Int, toRow : Int, toCol : Int) {
    //Checking for invalid input
        if (!isValidMove(fromRow: fromRow, fromCol: fromCol, toRow: toRow, toCol: toCol)) {
        //throw new IllegalArgumentException("Invalid move given");
    }
    
    self.board[toRow][toCol] = SLOT.Occupied;
    self.board[fromRow][fromCol] = SLOT.Empty;
        if (fromRow == toRow) {
            var betweenCol : Int = (fromCol - toCol == 2) ? toCol + 1 : toCol - 1;
            self.board[fromRow][betweenCol] = SLOT.Empty;
        } else {
            var betweenRow : Int = (fromRow - toRow == 2) ? toRow + 1 : toRow - 1;
            self.board[betweenRow][fromCol] = SLOT.Empty;
        }
        self.marbles -= 1;
    }
    
    
    public func isGameOver() -> Bool {
        if (getScore() == 1) {
            return true;
        }
        var hasMove : Bool = false
    
        for row in 0..<self.board.count {
            for col in 0..<self.board.count{
                let type : SLOT = self.board[row][col]
                
                if type == SLOT.Occupied {
                    //Checking Upward Marble
                    if (row > 1) {
                        hasMove = hasMove || self.isValidMove(fromRow: row, fromCol: col, toRow: row - 2, toCol: col);
                    }
                    //Checking Downward Marble
                    if (row < self.board.count - 2) {
                        hasMove = hasMove || self.isValidMove(fromRow: row, fromCol: col, toRow: row + 2, toCol: col);
                    }
                    
                    //checking left marble
                    if (col > 1) {
                        hasMove = hasMove || self.isValidMove(fromRow: row, fromCol: col, toRow: row, toCol: col - 2);
                    }
                    
                    //Checking right Marble
                    if (col < self.board.count - 2) {
                        hasMove = hasMove || self.isValidMove(fromRow: row, fromCol: col, toRow: row, toCol: col + 2);
                    }
                    
                }
            }
        }
        
    return !hasMove;
    }
    
    public func getGameState() -> String {
        var resultString : String = "";
        var type : SLOT
        for row in 0..<self.board.count {
            for col in 0 ..< self.board.count {
                type = self.board[row][col];
                switch (type) {
                case SLOT.Empty:
                    resultString += "_";
                    break;
                    
                case SLOT.Occupied:
                    resultString += "O";
                    break;
                    
                case SLOT.Unavailable:
                    if (self.armThickness > col) {
                        resultString += " ";
                    }
                    break;
                //default:
                    //throw Error.invalidSlotSelected
            }
                if (row < self.armThickness - 1 || row > (self.board.count - self.armThickness)) {
                    if (col == self.board.count - self.armThickness && row != self.board.count - 1) {
                        resultString += "\n";
                    } else if (col < self.board.count - self.armThickness) {
                        resultString += " ";
                    }
                } else {
                    if (col == self.board.count - 1) {
                        resultString += "\n";
                    } else {
                        resultString += " ";
                    }
                    
                }
                
            }
            
        }
        return resultString
    }
    

    public func getScore() -> Int {
        return self.marbles;
    }
    
    //Private methods
    private func validRowAndCol(row : Int, col : Int, boardLength : Int) -> Bool {
        return (row < boardLength && col < boardLength && row >= 0 && col >= 0);
    }
    
    //Computes the board center based on the given
    //armThickness
    private static func getBoardCenterFrom(armThickness : Int ) -> Int {
        return ((((armThickness - 1) * 2) + armThickness) / 2);
    }
    
    //Determines whether the desired move is valid.
    private func isValidMove(fromRow : Int, fromCol : Int, toRow : Int, toCol : Int) -> Bool
    {
        //Checking for invalid input
        return (validRowAndCol(row: fromRow, col: fromCol, boardLength: self.board.count)) //Valid fromRow & fromCol
            && (validRowAndCol(row: toRow, col: toCol, boardLength: board.count)) //Valid toRow & toCol
    && (self.board[fromRow][fromCol] == SLOT.Occupied) //from must have a marble
    && (self.board[toRow][toCol] == SLOT.Empty) //to must be empty
    && (
    //Checking if rows are the same
    ((fromRow == toRow)
    && (((fromCol - toCol) == 2)
    //Checking if marble between to and from
    && (self.board[toRow][toCol + 1] == SLOT.Occupied)))
    
    || ((fromRow == toRow)
    && (((fromCol - toCol) == -2)
    //Checking if marble between to and from
    && (self.board[toRow][toCol - 1] == SLOT.Occupied)))
    
    //Checking if cols are the same
    || ((fromCol == toCol)
    && (((fromRow - toRow) == 2)
    //Checking if marble between to and from
    && (self.board[toRow + 1][toCol] == SLOT.Occupied)))
    
    || ((fromCol == toCol)
    && (((fromRow - toRow) == -2)
    //checking if marble between to and from
    && (self.board[toRow - 1][toCol] == SLOT.Occupied))));
    }
    
    
}
