//: Playground - noun: a place where people can play

import Cocoa

for character in "Dog".characters {
    print(character)
}

//Character must contain a single character only
var character: Character = "!"

//Each item that you insert into the string literal is wrapped in a pair of parentheses, prefixed by a backslash:
let multipier = 3
let message = "\(multipier) times 2.5 is \(Double(multipier) * 2.5)"

//backslash(反斜杠)，a carriage return(回车), a line feed(换行)