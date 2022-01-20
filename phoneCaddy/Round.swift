//
//  Round.swift
//  phoneCaddy
//
//  Created by Kevin Tierney on 4/25/21.
//

import Foundation


class Round: ObservableObject {
    
    
    
    var scoreCard: ScoreCard
    var scores: Scores
    
    var currentHole: Int
    var currentPar: Int
    var currentStrokes: Int
    var currentDistance: Int
    
    
    init() {
        scoreCard = ScoreCard()
        scores = Scores()
        
        currentHole = 1
        currentPar = 4
        currentStrokes = 0
        currentDistance = 350
        
        
    }
    
    
//    Getters and setters
    func getComb() -> Array<Array<Int>> {
        return scoreCard.getHole()
    }
    
    func getCurrentHole() -> Int {
        return currentHole
    }
    
    func getHoles() -> Array<Int> {
        return scoreCard.getHoles()
    }
    
    func getPars() -> Array<Int> {
        return scoreCard.getPars()
    }
    
    func getStrokes() -> Array<Int> {
        return scoreCard.getStrokes()
    }
    
    func getDistances() -> Array<Int> {
        return scoreCard.getDistance()
    }
    
    func getScore() -> Int {
        var s = 0
        for score in scoreCard.getStrokes() {
            s += score
        }
        return s
    }
    
    func getAltScore() -> String {
        var s = 0
        var p = 0
        var x = ""
        for score in scoreCard.getStrokes() {
            s += score
        }
        for par in scoreCard.getPars() {
            p += par
        }
        let dif = s - p
        if (dif == 0) {
            x = "E"
        } else if (dif > 0) {
            x = "+\(String(dif))"
            
        } else {
            x = String(dif)
        }
        return x
    }
    
    // for scores page
    func getAvg() -> Int {
        return scores.getAverageScore()
    }
    
    func getAllScores() -> Array<Array<Array<Int>>> {
        return scores.getScores()
    }
    
    func get18() -> Array<Int> {
        var holes: Array<Int> = []
        for n in 1...18 {
            holes.append(n)
        }
        return holes
    }
    
    
    
    
    func setPar(par: Int) {
        currentPar = par
    }
    
    
    func subtractStroke() {
        currentStrokes -= 1
    }
    
    func addStroke() {
        currentStrokes += 1
    }
    
    func setDistance(dist: Int) {
        currentDistance = dist
    }
    
    
    
// update scorecard on next hole
    
    func nextHole() {
        if (currentHole == 19) {
            return
        }
        scoreCard.setPar(par: currentPar)
        scoreCard.setStroke(stroke: currentStrokes)
        scoreCard.setDistance(dis: currentDistance)
        scoreCard.setComb(hole: currentHole, par: currentPar, dis: currentDistance, stroke: currentStrokes)
        
        
        currentHole += 1
        currentPar = 4
        currentStrokes = 0
        currentDistance = 350
        
        
        
    }
    
    func newGame() {
        if (currentHole == 19) {
            scores.addScoreCard(card: scoreCard.getHole())
        }
        scoreCard = ScoreCard()
        currentHole = 1
        self.objectWillChange.send()
        return
    }
    
    
    
    
    
    
    
}





