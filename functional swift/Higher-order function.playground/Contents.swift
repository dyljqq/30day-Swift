//: Playground - noun: a place where people can play

import Cocoa

//map
func incrementArray(xs: [Int])-> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x + 1)
    }
    return result
}

func doubleArray(xs: [Int])-> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(x * 2)
    }
    return result
}

func computeArray(xs: [Int], transform: Int-> Int)-> [Int] {
    var result: [Int] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func doubleArrays(xs: [Int])-> [Int] {
    return computeArray(xs){ x in x * 2}
}

extension Array {
    func map<T>(transform: Element-> T) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

//Filter

let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]

func getFiles(files: [String])-> [String] {
    var result: [String] = []
    for file in files {
        if file.hasSuffix(".swift") {
            result.append(file)
        }
    }
    return result
}

getFiles(exampleFiles)

extension Array {
    func filter(includeElement: Element-> Bool)-> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}

func getFilter2(files: [String])-> [String] {
    return files.filter { file in file.hasSuffix(".swift") }
}

//Reduce

func sum(xs: [Int])-> Int {
    var sum = 0
    for x in xs {
        sum += x
    }
    return sum
}

extension Array {
    func reduce<T>(initial: T, combine: (T, Element)-> T)-> T {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        return result
    }
}

func concatUsingReduce(xs: [String])-> String {
    return xs.reduce("", combine: +)
}

//实际应用

struct City {
    let name: String
    let population: Int
}

let paris = City(name: "Paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)
let cities = [paris, madrid, amsterdam, berlin]

extension City {
    func cityByScalingPopulation()-> City {
        return City(name: name, population: population * 1000)
    }
}

cities.filter{ $0.population > 1000 }.map{ $0.cityByScalingPopulation() }.reduce("City: Population"){result, c in
    return result + "\n" + "\(c.name):\(c.population)"
}
