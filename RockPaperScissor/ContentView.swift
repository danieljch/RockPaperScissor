//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Daniel Jesus Callisaya Hidalgo on 9/12/21.
//

import SwiftUI

struct ContentView: View {
   
    let gameElements = ["rock", "paper","scissor"]
    let background =  LinearGradient(gradient: Gradient(colors: [.orange, .white]), startPoint: .top, endPoint: .bottom)
    let secondBackground = RadialGradient(stops: [
        .init(color: .orange, location: 0.1),
        .init(color: .white, location: 0.9),
    ], center: .top, startRadius: 200, endRadius: 900)
        
   @State private var gameMove = Int.random(in: 0...2)
    // gameIntention is true for WIN and false for LOSE
    @State private var gameIntention = Bool.random()
    @State private var score = 0
    
    var body: some View {
        ZStack {
                secondBackground
                    .ignoresSafeArea()
            VStack {
                
                Text("Rock Paper and Scissor")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                    .bold()
                    
                Text("Reply to")
                    .font(.title)
                    .bold()
                    .padding()
                ImageGame(text: gameElements[gameMove])
                Text("Play for " + (gameIntention ? "WIN" : "LOSE"))
                    .font(.title)
                    .bold()
                    .padding()
                ForEach(0..<3) { number in
                    Button(action:{
                        if gameIntention{
                        if playGame(with: number)  {score += 1}
                            else { score -= 1}
                        }
                        else { if !playGame(with: number) {
                            score += 1
                        } else { score -= 1}
                            
                        }
                        initGameRound()
                    } , label:{
                        ImageGame(text: gameElements[number])
                    })
                }
                Text("Score: \(score)")
            }
        }
            
    }
    func initGameRound() {
        gameIntention.toggle()
        gameMove = Int.random(in: 0...2)
    }
    func playGame(with number: Int) -> Bool {
        if ((gameMove + 1) % 3 == number) {
          return  true
        }
        return false
    }
}

struct ImageGame: View {
    var text: String
  
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.indigo, .white, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 180, height: 100, alignment: .center)
                .clipShape(Capsule())
                .shadow(color: .secondary, radius: 7, x: 10, y: 10)
            Image(text)
                .resizable()
                .frame(width: 140, height: 70, alignment: .center)
                .clipShape(Capsule())
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
