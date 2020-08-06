//
//  ContentView.swift
//  WeSplit
//
//  Created by Franco on 2020-07-30.
//  Copyright © 2020 Franco Fantillo. All rights reserved.
//

import SwiftUI

let coloredNavAppearance = UINavigationBarAppearance()

enum TempTypes: String {
    case Celcius
    case Fahrenheit
    case Kelvin
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
    
    let units = [TempTypes.Celcius.rawValue,
                 TempTypes.Fahrenheit.rawValue,
                 TempTypes.Kelvin.rawValue]
    
    @State private var unitToConvert = ""
    @State private var startIndexConvertFrom = 0
    @State private var startIndexConvertToo = 0
    
    var calculate: Double {
        
        let tempTypeFrom = TempTypes(rawValue: units[startIndexConvertFrom])
        let tempTypeToo = TempTypes(rawValue: units[startIndexConvertToo])
        
        switch tempTypeFrom {
            
            case .Celcius:
                return determineConvertToTypeFromCelcius(tooType: tempTypeToo!)
            case .Fahrenheit:
                return determineConvertToTypeFromFahrenheit(tooType: tempTypeToo!)
            case .Kelvin:
                return determineConvertToTypeFromKelvin(tooType: tempTypeToo!)
        case .none:
            fatalError("Not a temp type.")
        }
    }
    
    private func determineConvertToTypeFromCelcius(tooType: TempTypes) -> Double {
        
        let tempValue = Double(unitToConvert) ?? 0
        
        switch tooType {
            case .Celcius:
                return tempValue
            case .Fahrenheit:
                return celciusToFahrenheit(value: tempValue)
            case .Kelvin:
                return celciusToKelvin(value: tempValue)
        }
    }
    
    private func determineConvertToTypeFromFahrenheit(tooType: TempTypes) -> Double {
        
        let tempValue = Double(unitToConvert) ?? 0
        
        switch tooType {
            case .Celcius:
                return fahrenheitToCelcius(value: tempValue)
            case .Fahrenheit:
                return tempValue
            case .Kelvin:
                return fahrenheitToKelvin(value: tempValue)
        }
    }
    
    private func determineConvertToTypeFromKelvin(tooType: TempTypes) -> Double {
        
        let tempValue = Double(unitToConvert) ?? 0
        
        switch tooType {
            case .Celcius:
                return kelvinToCelcius(value: tempValue)
            case .Fahrenheit:
                return kelvinToFahrenheit(value: tempValue)
            case .Kelvin:
                return tempValue
        }
    }
    
    private func celciusToKelvin(value: Double) -> Double{
        return value + 273.15
    }
    
    private func celciusToFahrenheit(value: Double) -> Double{
        return (value * (9/5)) + 32
    }
    
    private func fahrenheitToCelcius(value: Double) -> Double{
        return (value - 32) * (5/9)
    }
    
    private func fahrenheitToKelvin(value: Double) -> Double{
        return (value - 32) * (5/9)
    }
    
    private func kelvinToCelcius(value: Double) -> Double{
        return value - 273.15
    }
    
    private func kelvinToFahrenheit(value: Double) -> Double{
        return ((value - 273.15) * (9/5)) + 32
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Pick Your Temperature Unit.")) {
                    Section {
                        Picker("Tip percentage", selection: $startIndexConvertFrom) {
                            ForEach(0 ..< units.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section(header: Text("Enter Your Temperature to Convert.")) {
                    Section {
                        TextField("Temperature Value", text: $unitToConvert)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section(header: Text("Pick Your Temperature Unit to Convedrt Too.")) {
                    Section {
                        Picker("Tip percentage", selection: $startIndexConvertToo) {
                            ForEach(0 ..< units.count) {
                                Text("\(self.units[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section(header: Text("Converted Temp")) {
                    Section {
                        Text("\(calculate, specifier: "%.2f")")
                    }
                }
                
            }
            .navigationBarTitle("Temp Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
