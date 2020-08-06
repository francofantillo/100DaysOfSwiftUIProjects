//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Franco on 2020-08-06.
//  Copyright © 2020 Franco Fantillo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false

    var body: some View {
        
        ZStack{
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
            .edgesIgnoringSafeArea(.all)
            Circle()
                .frame(width: 300, height: 300)
                .foregroundColor(.white)
            .shadow(color: .black, radius: 15, x: 0, y: 8)
            Button("Show Alert") {
                self.showingAlert = true
                
            }
            .foregroundColor(.black)
            .frame(width: 300, height: 100)
            .font(.custom("Marker Felt", size: 40))
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Hello!"), message: Text("This is to alert you that the button was pressed."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
