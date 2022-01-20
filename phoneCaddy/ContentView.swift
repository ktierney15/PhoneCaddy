//
//  ContentView.swift
//  phoneCaddy
//
//  Created by Kevin Tierney on 4/25/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Phone Caddy")
                    .font(Font.custom("FredokaOne-Regular", size: 80))
                    .padding(60)
                    .foregroundColor(.black)
                NavigationLink(destination: GameView(round: Round())) {
                    Text("New Round")
                        .font(.title3)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.black)
                        .padding(20)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black))
                        
                        
                }.padding([.leading, .trailing], 20)
                NavigationLink(destination: ScoresView(round: Round())) {
                    Text("Scores")
                        .font(.title3)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.black)
                        .padding(20)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black))
                        
                        
                }.padding([.leading, .trailing], 20)
            }
            .background(
                Image("unnamed")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(0.3)
                )

        }
        
    }
}



struct GameView: View {
    
    @ObservedObject var round: Round
    
    @State var distance: Double = 0.5
    @State var stroke: Int = 0
    @State private var didTap3:Bool = false
    @State private var didTap4:Bool = false
    @State private var didTap5:Bool = false
    
    var body: some View {
        
        VStack {
            Text("Current Score: \(round.getScore()) (\(round.getAltScore()))")
                .font(Font.custom("Pangolin-Regular", size: 30))
        // scorecard
            ScrollView(.horizontal, showsIndicators: false) {
            HStack (alignment: .center, spacing: 0, content: {
                VStack {
                    Text("Hole")
                    Text("Par")
                    Text("Distance")
                    Text("Strokes")
                }
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 1)
                            .stroke(Color.black))
                ForEach(round.getComb(), id: \.self) { hole in
                    if (hole[0] > 0) {
                        ScoreColumn(hole: hole[0], distance: hole[1], par: hole[2], stroke: hole[3])
                            
                    }
                        
                }
            })
        }
            
        
        
        // current hole
        
            // par (3 buttons)
            HStack {
                Text("Par: ")
                    .font(Font.custom("Pangolin-Regular", size: 40))
                Button(action: {
                    round.setPar(par: 3)
                    self.didTap3 = true
                    self.didTap4 = false
                    self.didTap5 = false
                    
                }, label: {
                    Text("3")
                        .font(Font.custom("Pangolin-Regular", size: 25))
                        .padding(20)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 100)
                                    .stroke(self.didTap3 ? Color.green : Color.black))
                    
                })
                Button(action: {
                    round.setPar(par: 4)
                    self.didTap3 = false
                    self.didTap4 = true
                    self.didTap5 = false
                }, label: {
                    Text("4")
                        .font(Font.custom("Pangolin-Regular", size: 25))
                        .padding(20)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 100)
                                    .stroke(self.didTap4 ? Color.green : Color.black))
                    
                })
                Button(action: {
                    round.setPar(par: 5)
                    self.didTap3 = false
                    self.didTap4 = false
                    self.didTap5 = true
                }, label: {
                    Text("5")
                        .font(Font.custom("Pangolin-Regular", size: 25))
                        .padding(20)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 100)
                                    .stroke(self.didTap5 ? Color.green : Color.black))
                    
                    
                })
            }.padding()
            // strokes (plus/minus)
            HStack {
                Text("Strokes: ")
                    .font(Font.custom("Pangolin-Regular", size: 40))
                Button(action: {
                    if stroke > 0 {
                        stroke -= 1
                        round.subtractStroke()
                    }
                }, label: {
                    Text(" - ")
                        .font(.title3)
                        .padding(10)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black))
                    
                })
                Text("\(stroke)")
                    .font(Font.custom("Pangolin-Regular", size: 50))
                Button(action: {
                    stroke += 1
                    round.addStroke()
                }, label: {
                    Text(" + ")
                        .font(.title3)
                        .padding(10)
                        .foregroundColor(.black)
                        .overlay(RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.black))
                    
                })
            }.padding()
        
            // distance (slider)
            HStack {
                
                Text("Distance: \(Int(distance * 700))")
                    .font(Font.custom("Pangolin-Regular", size: 40))
                    
            }.padding()
            DistanceSlider(distance: $distance)
        
        // next hole button
            Button(action: {
                if stroke != 0 {
                    round.setDistance(dist:Int(distance * 700))
                    round.nextHole()
                    distance = 0.5
                    stroke = 0
                    self.didTap3 = false
                    self.didTap4 = false
                    self.didTap5 = false
                }
            }, label: {
                Text("Next Hole")
                    .font(.title3)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.black)
                    .padding(20)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black))
            }).padding([.leading, .trailing], 20)
            
            // new game
            Button(action: {
                round.newGame()
            }, label: {
                Text("New Game")
                    .font(.title3)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.black)
                    .padding(20)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black))
            }).padding([.leading, .trailing], 20)
            
            
        }
        
        
//        .background(
//            Image("golf")
//                .resizable()
//                .edgesIgnoringSafeArea(.all)
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .opacity(0.1)
//            )
        
        
    }
}

struct ScoresView: View {
    
    @ObservedObject var round: Round
    
    var body: some View {
        VStack {
        // average score
            Text("Average Score: \(round.getAvg())")
                .font(Font.custom("Pangolin-Regular", size: 40))
            .padding(20)
        // scorecards with dates

        
        }
        .background(
            Image("golf")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .opacity(0.1)
            )
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        GameView(round: Round())
        ScoresView(round: Round())
    }
}



struct ScoreColumn: View {
    var hole: Int
    var distance: Int
    var par: Int
    var stroke: Int
    
    var body: some View {
        VStack {
            
            Text("\(hole)")
                .frame(width: 40)
                .background(Color.green)
                .overlay(RoundedRectangle(cornerRadius: 1)
                            .stroke(Color.black))
            Text("\(distance)")
                .frame(width: 40)
                .background(Color.yellow)
                .overlay(RoundedRectangle(cornerRadius: 1)
                            .stroke(Color.black))
            Text("\(par)")
                .frame(width: 40)
                .background(Color.orange)
                .overlay(RoundedRectangle(cornerRadius: 1)
                            .stroke(Color.black))
            Text("\(stroke)")
                .frame(width: 40)
                .background(Color.white)
                
                
        }
        .overlay(RoundedRectangle(cornerRadius: 1)
                    .stroke(Color.black))
        
    }
    
}




struct DistanceSlider: View {
    @Binding var distance: Double
    
    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(.black)
            Slider(value: $distance)
                .colorMultiply(.black)
            Text("700")
                .foregroundColor(.black)
        }
        .padding()
    }
}
