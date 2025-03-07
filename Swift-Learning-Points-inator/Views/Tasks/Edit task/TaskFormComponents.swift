//
//  TaskFormComponents.swift
//  Swift-Learning-Points-inator
//
//  Created by Izabela Marcinkowska on 2025-02-28.
//

import SwiftUI

struct SchoolPickerView: View {
    @Binding var selectedSchool: SchoolOfMagic
    
    var body: some View {
        HStack {
            Spacer()
            
            Image(selectedSchool.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            
            Picker("", selection: $selectedSchool) {
                ForEach(SchoolOfMagic.allCases, id: \.self) { school in
                    Text(school.rawValue)
                        .tag(school)
                }
            }
            .labelsHidden()
            .pickerStyle(MenuPickerStyle())
            
            Spacer()
        }
    }
}

struct DifficultyPickerView: View {
    @Binding var selectedDifficulty: TaskDifficulty
    @Binding var mana: Int
    
    var body: some View {
        HStack {
            Spacer()
            
            Image(selectedDifficulty.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            
            Picker("", selection: $selectedDifficulty) {
                ForEach(TaskDifficulty.allCases, id: \.self) { difficulty in
                    Text(difficulty.rawValue).tag(difficulty)
                }
            }
            .onChange(of: selectedDifficulty) { oldValue, newValue in
                let minValue = Int(newValue.suggestedManaRange.split(separator: "-")[0]) ?? 20
                mana = minValue
            }
            .labelsHidden()
            .pickerStyle(MenuPickerStyle())
            
            Spacer()
        }
    }
}

struct ManaSliderView: View {
    @Binding var mana: Int
    let difficulty: TaskDifficulty
    
    private func sliderRange() -> ClosedRange<Double> {
        let rangeString = difficulty.suggestedManaRange
        let components = rangeString.split(separator: "-")
        guard components.count == 2,
              let min = Double(components[0]),
              let max = Double(components[1]) else {
            return 1...100
        }
        return min...max
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(mana)")
                    .font(.headline)
                    .frame(width: 50, alignment: .leading)
                
                Spacer()
                
                Text(difficulty.suggestedManaRange)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Slider(value: Binding(get: { Double(mana) }, set: { mana = Int($0) }), in: sliderRange(), step: 1)
                .tint(difficulty.textColor)
        }
    }
}
