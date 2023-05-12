//
//  PrioritySelector.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 12/05/2023.
//

import SwiftUI

struct PrioritySelector: View {
    @State private var hide: Bool = false
    @Binding var selectedPriority: String
    let nuanceGris = Color(white: 0.4)

    var body: some View {
        VStack {
        if !hide {
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Button {
                                withAnimation {
                                    hide = true
                                }
                                selectedPriority = priority.rawValue
                            } label: {
                                Text(priority.rawValue)
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color("AccentBlue"))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            } else {
                HStack {
                    Image(systemName: selectedPriority == "Faible" ? "flag" : "flag.fill")
                        .foregroundColor(priorityColor(for: selectedPriority))
                    Text(selectedPriority)
                    Text("|")
                        .opacity(0.4)
                        .fontWeight(.light)
                    Button {
                        withAnimation {
                            hide = false
                            selectedPriority = ""
                        }
                    } label: {
                        Image(systemName: "multiply")
                    }
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(nuanceGris, lineWidth: 1)
                )
            }
        }
    }
}

struct PrioritySelector_Previews: PreviewProvider {
    static var previews: some View {
        PrioritySelector(selectedPriority: .constant("Urgent"))
            .padding()
            .background(Color("lightBlue"))
            .previewLayout(.sizeThatFits)
    }
}
