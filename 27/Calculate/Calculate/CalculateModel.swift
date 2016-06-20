//
//  CalculateModel.swift
//  Calculate
//
//  Created by 季勤强 on 16/6/20.
//  Copyright © 2016年 季勤强. All rights reserved.
//

import UIKit

class CalculateModel: NSObject {

    enum Operation {
        case UnaryOperation(String, Double -> Double)
        case BinaryOperarion(String, (Double, Double) -> Double)
    }
    
    var opStack = [Operation]()
    var nums = [Double]()
    var knownOps = [String: Operation]()
    
    override init() {
        knownOps["+"] = Operation.BinaryOperarion("+", +)
        knownOps["-"] = Operation.BinaryOperarion("-") { $1 - $0 }
        knownOps["×"] = Operation.BinaryOperarion("×", *)
        knownOps["÷"] = Operation.BinaryOperarion("÷") { $1 / $0}
        knownOps["√"] = Operation.UnaryOperation("√") { sqrt($0) }
        knownOps["="] = Operation.UnaryOperation("=") { $0 }
    }
    
    func pushOperand(operand: Double) {
        nums.append(operand)
    }
    
    func performOPeration(symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
    
    func evaluate() -> Double? {
        let result: Double = evaluate(opStack)
        nums.append(result)
        return result
    }
    
    private func evaluate(ops: [Operation]) -> Double {
        if opStack.isEmpty {
            return nums.removeLast()
        }
        let op = opStack.removeLast()
        switch op {
        case .UnaryOperation(_, let operation):
            if nums.count >= 1{
                return operation(nums.removeLast())
            }
        case .BinaryOperarion(_, let operation):
            if nums.count >= 2 {
                return operation(nums.removeLast(), nums.removeLast())
            }
        }
        return 0
    }
    
    private func evaluate(ops: [Operation]) -> (result: Double?, remainingOps: [Operation]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
//            switch op {
//            case .Operand(let operand):
//                if !remainingOps.isEmpty {
//                    evaluate(remainingOps)
//                }
//                return (operand, remainingOps)
//            case .UnaryOperation(_, let operation):
//                let operationEvaluate = evaluate(remainingOps)
//                if let operand = operationEvaluate.result {
//                    return (operation(operand), operationEvaluate.remainingOps)
//                }
//            case .BinaryOperarion(_, let operation):
//                let op1Evaluate = evaluate(remainingOps)
//                if let operand1 = op1Evaluate.result {
//                    let op2Evaluate = evaluate(remainingOps)
//                    if let operand2 = op2Evaluate.result {
//                        return (operation(operand1, operand2), op2Evaluate.remainingOps)
//                    }
//                }
//            }
        }
        return (nil, ops)
    }
    
}
