//
//  AccentButton.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 09/04/2023.
//

import SwiftUI

struct AccentButton: View {
    let name : String
    let color : Color
    let action : () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(name)
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .padding(.horizontal,12)
                .background(color)
                .cornerRadius(.infinity)
                .padding()
        }
    }
}

struct AccentButton_Previews: PreviewProvider {
    static var previews: some View {
        AccentButton(name: "Ajouter", color:.black,action: {})
            .previewLayout(.sizeThatFits)
    }
}
