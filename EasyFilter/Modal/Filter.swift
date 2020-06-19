//
//  Image.swift
//  EasyFilter
//
//  Created by Emre Çelik on 9.06.2020.
//  Copyright © 2020 Emre Çelik. All rights reserved.
//

import Foundation

struct Filter {
    var gamma: Float            //   0.5 - 1.5
    var exposureAdjust: Float   //  -3.0 - 1.5
    var hue: Float              //  -1.0 - 1.0
    var vibrance: Float         //   0.0 - 10
    var colorPasterize: Float   //  15.0 - 100
    var sepia: Float            //  -0.5 - 0.5
    var vignette: Float         //  -1.0 - 3.5
    var sharpenLuminance: Float //  -0.4 - 0.4
    var weight: Float
    
    init() {
        gamma            = Float.random(in:  0.5..<1.5)
        exposureAdjust   = Float.random(in: -3.0..<1.5)
        hue              = Float.random(in: -1.0..<1.0)
        vibrance         = Float.random(in:  0.0..<10.0)
        colorPasterize   = Float.random(in: 15.0..<100.0)
        sepia            = Float.random(in: -0.5..<0.5)
        vignette         = Float.random(in: -1.0..<3.5)
        sharpenLuminance = Float.random(in: -0.4..<0.4)
        weight = 0
    }
    
    init(filter: Filter) {
        gamma            = filter.gamma
        exposureAdjust   = filter.exposureAdjust
        hue              = filter.hue
        vibrance         = filter.vibrance
        colorPasterize   = filter.colorPasterize
        sepia            = filter.sepia
        vignette         = filter.vignette
        sharpenLuminance = filter.sharpenLuminance
        weight           = filter.weight
    }
    
    init(dna: [Float]) {
        gamma            = dna[0]
        exposureAdjust   = dna[1]
        hue              = dna[2]
        vibrance         = dna[3]
        colorPasterize   = dna[4]
        sepia            = dna[5]
        vignette         = dna[6]
        sharpenLuminance = dna[7]
        weight           = 0
    }
    
    mutating func setFilter(filter: Filter) {
        gamma            = filter.gamma
        exposureAdjust   = filter.exposureAdjust
        hue              = filter.hue
        vibrance         = filter.vibrance
        colorPasterize   = filter.colorPasterize
        sepia            = filter.sepia
        vignette         = filter.vignette
        sharpenLuminance = filter.sharpenLuminance
    }
    
    mutating func setDNA(dna: [Float]) {
        gamma            = dna[0]
        exposureAdjust   = dna[1]
        hue              = dna[2]
        vibrance         = dna[3]
        colorPasterize   = dna[4]
        sepia            = dna[5]
        vignette         = dna[6]
        sharpenLuminance = dna[7]
    }
    
    func getDNA() -> [Float] {
        return [gamma,
                exposureAdjust,
                hue,
                vibrance,
                colorPasterize,
                sepia,
                vignette,
                sharpenLuminance
        ]
    }

}
