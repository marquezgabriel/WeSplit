//
//  ContentView.swift
//  WeSplit
//
//  Created by Gabriel Marquez on 2022-05-26.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 15
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
    
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmountCheck: Double {
        let tipFactor = Double(tipPercentage)

        let totalCheck =   checkAmount + (checkAmount * (tipFactor / 100))
        
        return totalCheck
    }
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    @FocusState private var amountIsFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text (totalAmountCheck, format: localCurrency)
                }
                    header: {
                        Text("Total for the check")
                    }
                Section {
                    Text (totalPerPerson, format: localCurrency)
                }
                    header: {
                        Text("Amount to pay per person")
                    }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
