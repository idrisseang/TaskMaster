//
//  DatePickerButton.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 11/04/2023.
//

import SwiftUI

struct DatePickerButton: View {
    let title : String
    let timeVariation : Calendar.Component
    let value : Int
    let iconName : String
    @Binding var currentDate : Date
    let onClick : () -> Void
    
    var body: some View {
        Button {
            let calendar = Calendar.current
            let datePicked = calendar.date(byAdding: timeVariation, value: value,to: currentDate)
            currentDate = datePicked!
            onClick()
            
        } label: {
            VStack{
                Image(systemName: iconName)
                    .font(.footnote)
                Text(title)
                    .font(.footnote)
                    .bold()
            }
            .foregroundColor(.white)
            .padding(4)
            .background(Color("AccentBlue"))
            .cornerRadius(8)
        }
    }
}

struct DatePickerButton_Previews: PreviewProvider {
    @State private var taskDate = Date()
    static var previews: some View {
        DatePickerButton(title: "Aujourd'hui", timeVariation: .hour, value: 1, iconName: "sunrise",currentDate: .constant(Date()), onClick: {})
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
