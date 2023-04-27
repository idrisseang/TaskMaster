//
//  ChooseDateHourButton.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 12/04/2023.
//

import SwiftUI

struct ChooseDateHourButton: View {
    @State private var isShowingDatePickerScreen : Bool = false
    @Binding var date : Date?
    @Binding var hide : Bool
    
    var body: some View {
        VStack{
            Button {
                isShowingDatePickerScreen = true
            } label: {
                VStack{
                    Image(systemName: "calendar.badge.clock")
                        .font(.footnote)
                    Text("Date et heure")
                        .font(.footnote)
                        .bold()
                }
                .foregroundColor(.white)
                .padding(4)
                .background(Color("AccentBlue"))
                .cornerRadius(8)
            }
        }
        .sheet(isPresented: $isShowingDatePickerScreen) {
            DatePickerScreen(date: $date,hide: $hide)
        }
    }
}

struct ChooseDateHourButton_Previews: PreviewProvider {
    static var previews: some View {
        ChooseDateHourButton(date: .constant(Date()), hide: .constant(false))
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color("lightBlue"))
    }
}
