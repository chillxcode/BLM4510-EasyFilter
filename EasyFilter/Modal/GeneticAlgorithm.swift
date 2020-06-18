//
//  GeneticAlgorithm.swift
//  EasyFilter
//
//  Created by Emre Çelik on 9.06.2020.
//  Copyright © 2020 Emre Çelik. All rights reserved.
//

import UIKit

public class GeneticAlgorithm {
    private let DNA_SIZE = 8            //Filter Count
    private let POP_SIZE = 6            //Card Size
    private let MUTATION_CHANCE = 10    //10 in 1
    
    func randomPopulation() -> [Filter] {
        var population = [Filter]()
        (0..<POP_SIZE).forEach { (_) in
            population.append(Filter())
        }
        return population
    }
    
    func weightedChoice(items: [Filter]) -> Filter {
        let total = items.reduce(0) {$0 + $1.weight}
        var n: Float = 0
        if total == 0 { return items[Int.random(in: 0..<items.count)] }
        else { n = Float.random(in: 0..<total) }
        
        for item in items {
            if item.weight > n {
                return item
            }
            n = n - item.weight
        }
        return items[Int.random(in: 0..<items.count)]
    }
    
    func mutate(dna: [Float]) -> [Float] {
        var outputDna = dna
        (0..<DNA_SIZE).forEach { (i) in
            let rand = Int.random(in: 0..<MUTATION_CHANCE)
            if rand == 1 {
                switch i {
                case 0:
                    outputDna[0] = Float.random(in: 0.5..<1.5)
                case 1:
                    outputDna[1] = Float.random(in: -3.0..<1.5)
                case 2:
                    outputDna[2] = Float.random(in: -1.0..<1.0)
                case 3:
                    outputDna[3] = Float.random(in: 0.0..<10.0)
                case 4:
                    outputDna[4] = Float.random(in: 15.0..<100.0)
                case 5:
                    outputDna[5] = Float.random(in: -0.5..<0.5)
                case 6:
                    outputDna[6] = Float.random(in: -1.0..<3.5)
                case 7:
                    outputDna[7] = Float.random(in: -0.4..<0.4)
                default:
                    print("MUTATION DEFAULT CASE")
                }
            }
        }
        return outputDna
    }
    
    func crossover(dna1: [Float], dna2: [Float]) -> [Float] {
        let pos = Int.random(in: 0..<DNA_SIZE)
        
        let dna1Index1 = dna1.index(dna1.startIndex, offsetBy: pos)
        let dna2Index1 = dna2.index(dna2.startIndex, offsetBy: pos)
        
        return [Float](dna1.prefix(upTo: dna1Index1) + dna2.suffix(from: dna2Index1))
    }
    
    func calculate(items: [Filter]) -> [Filter]{
        let weightedPopulation = items
        var population = [Filter]()
        
        (0..<POP_SIZE).forEach { (_) in
            let ind1 = weightedChoice(items: weightedPopulation)
            let ind2 = weightedChoice(items: weightedPopulation)
            
            let offSpring = crossover(dna1: ind1.getDNA(), dna2: ind2.getDNA())
            
            var filter = Filter()
            filter.setDNA(dna: mutate(dna: offSpring))
            population.append(filter)
        }
        return population
    }
    
}
