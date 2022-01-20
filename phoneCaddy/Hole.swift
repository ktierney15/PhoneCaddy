//
//  Hole.swift
//  phoneCaddy
//
//  Created by Kevin Tierney on 5/4/21.
//

import Foundation

struct Hole: Identifiable {
    let id = UUID()
    var hole: Int
    var par: Int
    var strokes: Int
    var distance: Int
}
