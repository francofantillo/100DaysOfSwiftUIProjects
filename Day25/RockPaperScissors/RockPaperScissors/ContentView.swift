//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Franco on 2020-08-14.
//  Copyright © 2020 Franco Fantillo. All rights reserved.
//

import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()

struct Option: View {
    var string: String
    
    var body: some View {
        Text(string)
            .font(.system(size: 60))
    }
}

struct ContentView: View {
    
    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = .black
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    @State private var showingAlert = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var moveType = Int.random(in: 0...2)
    @State private var win = Bool.random()
    @State private var options = ["✋", "✊", "✌️"]
    private var instructions: String {
        let begining = "The User Needs To "
        if win {
            return begining + "Win"
        }
        return begining + "Lose"
    }
    
    var body: some View {
        
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    Text(instructions)
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                    
                    Option(string: options[moveType])
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                    
                    Text("Choose Your Move")
                        .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                    
                    HStack{
                        
                        ForEach(0 ..< 3) { number in
                            Button(action: {
                                self.optionChosen(number: number, win: self.win)
                            }) {
                                Option(string: self.options[number])
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")) {
                            self.win = Bool.random()
                            self.moveType = Int.random(in: 0...2)
                            })
                    }
                    Spacer()

                    ZStack{
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 1000, height: 150)
                            
                        
                        Text("Score: \(userScore)")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
                    
                }
                .navigationBarTitle("Rock Paper Scissors")
                .edgesIgnoringSafeArea(.bottom)
            }

        }
    }
    
    func optionChosen(number: Int, win: Bool){
        
        var num: Int!
        
        // Changes the button number to match the option index based on whether you
        // were to win or lose.
        
        if win == true {
            num = number + 1
            if num > 2 {
                num = 0
            }
        } else {
            num = number - 1
            if num < 0 {
                num = 2
            }
        }
        
        if num == moveType {
            scoreTitle = "Correct"
            userScore = userScore + 1
        } else {
            scoreTitle = "Wrong"
            userScore = userScore - 1
        }
        
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
