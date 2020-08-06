//
//  ContentView.swift
//  WeSplit
//
//  Created by Franco on 2020-07-30.
//  Copyright © 2020 Franco Fantillo. All rights reserved.
//

import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()

struct ContentView: View {
    
    let tipPercentages = [10, 15, 20, 25, 0]
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue

        return grandTotal
    }
    
    init() {
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = .black
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Enter the bill amount.")) {
                    Section {
                        TextField("Bill Amount", text: $checkAmount)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0 ..< tipPercentages.count) {
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section {
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Grand Total")) {
                    Section {
                        Text("$\(grandTotal, specifier: "%.2f")")
                    }
                }
                
                Section(header: Text("Amount Per Person")) {
                    Section {
                        Text("$\(totalPerPerson, specifier: "%.2f")")
                    }
                }
                
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
