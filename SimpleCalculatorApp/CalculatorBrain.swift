//
//  CalculatorBrain.swift
//  SimpleCalculatorApp
//
//  Created by Shanky on 9/20/15.
//  Copyright © 2015 Shanky. All rights reserved.
//

import Foundation

class CalBrain
{

    private enum op: CustomStringConvertible{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self{
                case .Operand(let operand):
                        return "\(operand)"
                case .UnaryOperation(let symbol, _):
                        return symbol
                case .BinaryOperation(let symbol, _):
                        return symbol
                }
            }
        }
    }
    
    private var opStack = [op]()
    private var knownOp = [String:op]()

    
    init(){
        knownOp["x"] = op.BinaryOperation("x", *)
        knownOp["+"] = op.BinaryOperation("+", +)
        knownOp["/"] = op.BinaryOperation("/") { $1 / $0 }
        knownOp["-"] = op.BinaryOperation("-") { $1 / $0 }
        knownOp["root"] = op.UnaryOperation("root", sqrt)
    }
    
    private func evaluate(ops:[op]) -> (result: Double?, remainingOps: [op]){
        
        if !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op{
            case .Operand(let operand):
                return (operand, remainingOps)
            
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                       return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        
        return (nil, ops)
    }
    
    
    func evaluate() -> Double? {
            let (result, _) = evaluate(opStack)
            return result
    }
    
    func pushOperand(operand : Double) -> Double? {
        opStack.append(op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol:String) -> Double? {
        if let operation = knownOp[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
    
}
