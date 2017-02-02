//
//  Calculator.swift
//  Calculator
//
//  Created by luc Casimir on 28/01/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import Foundation

class Calculator{
    
    typealias PropertyList = Any
    private var accumulator = 0.0
    private var internalProgam = [Any]()
    
    func setOperator(operand: Double)
    {
        accumulator = operand
        internalProgam.append(operand)
    }
    
    private enum Operation
    {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private struct BinaryOperation
    {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
        func execute(number: Double) -> Double
        {
            return binaryFunction(firstOperand, number)
        }
    }
        
    private var pending : BinaryOperation?
    
    private var operations : Dictionary <String, Operation> =
    [
        //Constant
        "C" : Operation.Constant(0.0),
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        //Unary
        "±" : Operation.UnaryOperation({$0 * -1}),
        "√" : Operation.UnaryOperation(sqrt),
        //Binary
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "x" : Operation.BinaryOperation({$0 * $1}),
        "/" : Operation.BinaryOperation({$0 / $1}),
        //Equals?
        "=" : Operation.Equals
    ]
    
    private func executeBinaryOperation()
    {
        if let binaryOperation = pending{
            accumulator = binaryOperation.execute(number: accumulator)
            pending = nil
        }
    }
    
    func performOperator(_ symbol: String)
    {
        if let operation = operations[symbol]{
            switch operation {
            case .BinaryOperation(let function):
                executeBinaryOperation()
                pending = BinaryOperation(binaryFunction: function, firstOperand: accumulator)
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .Constant(let value):
                if value == 0.0 { clear()}
                accumulator = value
            case .Equals:
                executeBinaryOperation()
            }
        }
    }
    
    var program : PropertyList
    {
        get {
            return internalProgam
        }
        set {
            clear()
            if let arrayOfOperations = newValue as? [Any]{
                for op in arrayOfOperations
                {
                    if let operand = op as? Double {
                        setOperator(operand: operand)
                    }
                    else if let operation = op as? String {
                        performOperator(operation)
                    }
                }
            }
        }
    }
    
    func clear()
    {
        accumulator = 0.0
        internalProgam.removeAll()
        pending = nil
    }
    
    var result : Double
    {
        get
        {
            return accumulator
        }
    }
}
