//
//  Scores.swift
//  phoneCaddy
//
//  Created by Kevin Tierney on 5/5/21.
//

import Foundation

class Scores {
    
    var averageScore = 0
    var scoreCards: Array<Array<Array<Int>>> = []
    
    
//    getters and setters
    func getScores() -> Array<Array<Array<Int>>> {
        return scoreCards
    }
    
    func getAverageScore() -> Int {
        return averageScore
    }
    
    func newAverage() {
        var sum = 0
        for card in scoreCards {
            // take the sum and add it to the total
            for hole in card {
                sum += hole[3]
            }
        }
        // average the total scores and update the value
        let avg = sum / scoreCards.count
        // new average
        UserDefaults.standard.set(avg, forKey: "AverageScore")
        
    }
    
    
    func addScoreCard(card: Array<Array<Int>>) {
        scoreCards.append(card)
        newAverage()
    }
    
    
    
}
