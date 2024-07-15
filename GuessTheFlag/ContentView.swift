//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Frank Grullon on 11/7/24.
//

import SwiftUI


struct FlagImage: View {
    var countryFlag : String
    @ViewBuilder var body : some View {
        Image(countryFlag)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}


struct ContentView: View {
    @State private var countries: [String] = ["Estonia","France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var userScore = 0
    @State private var attempts = 0
    @State private var answer = false
    @State private var altText = ""

    @State private var showindScore = false
    @State private var scoreTitle = ""
    


    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3){ number in
                    Button{
                        flagTapped(number)
                    } label: {
                        FlagImage(countryFlag: countries[number])
              
                    }
                    
                }
            }
        }
        .alert(scoreTitle, isPresented: $showindScore){
            if(attempts == 8){
                Button("Restart", action: restart)
            } else {
                Button("Continue", action: nextQuestion)
            }
            
        } message: {
            if(attempts == 8){
                Text("Your score is \(userScore) / \(attempts)")
            } else {
                Text(altText)
            }
        }
    }
    
    func flagTapped(_ number: Int){
        if(number == correctAnswer){
            userScore += 1
            scoreTitle = "Correct"
        }else{
            scoreTitle = "Wrong"
            altText = "Wrong! That’s the flag of \(countries[number])"
        }
        
        attempts += 1
        showindScore = true

        if(attempts == 8){
        
            if(userScore <= 5){
                scoreTitle = "Best luck next round"
            }else if (userScore <= 7){
                scoreTitle = "Almost Perfect, you got this!"
            }else {
                scoreTitle = "Congrats! Perfect Score"
            }
        }
        
        nextQuestion( )
    }
    
    func nextQuestion( ){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart( ){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        showindScore = false
        attempts = 0
        userScore = 0
    }
}

#Preview {
    ContentView()
}
