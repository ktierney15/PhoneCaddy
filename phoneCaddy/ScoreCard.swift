//
//  ScoreCard.swift
//  phoneCaddy
//
//  Created by Kevin Tierney on 4/25/21.
//

import Foundation

struct ScoreCard {
    
    //let Cards: [ScoreCard] = []
    
    var ScoreCard: [Hole] = []
    
    
    mutating func addHole(h: Int, p: Int, s: Int, d: Int) {
        ScoreCard.append(Hole(hole: h, par: p, strokes: s, distance: d))
    }
    
    
    var holes: Array<Int>
    var pars: Array<Int>
    var strokes: Array<Int>
    var distance: Array<Int>
    var comb: Array<Array<Int>>

    init() {
        holes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
        pars = [0]
        strokes = [0]
        distance = [0]
        comb = [[0, 0, 0, 0]]
    }

    func getHole() -> Array<Array<Int>> {
        return comb
    }
    
    func getHoles() -> Array<Int> {
        return holes
    }

    func getPars() -> Array<Int> {
        return pars
    }

    func getStrokes() -> Array<Int> {
        return strokes
    }

    func getDistance() -> Array<Int> {
        return distance
    }

    mutating func setComb(hole: Int, par: Int, dis: Int, stroke: Int) {
        comb.append([hole, par, dis, stroke])
    }

    mutating func setPar(par: Int) {
        pars.append(par)
    }

    mutating func setStroke(stroke: Int) {
        strokes.append(stroke)
    }

    mutating func setDistance(dis: Int) {
        distance.append(dis)
    }
    
}


