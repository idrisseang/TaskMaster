//
//  DatePickerScreen.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 12/04/2023.
//

import SwiftUI

struct DatePickerScreen: View {
    @Environment (\.presentationMode) var presentationMode
    @Binding var date: Date?
    @FocusState private var isFocused: Bool
    @Binding var isShowingHour: Bool
    @Binding var hide: Bool

    var body: some View {
        VStack {
            header
            Spacer()
            VStack(alignment: .leading) {
                CustomLabel(title: "Date", icon: "calendar")
                separator
                datePickerSection(displayedComponent: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                separator
                HStack {
                    CustomLabel(title: "Heure", icon: "clock")
                    Toggle("", isOn: $isShowingHour)
                        .toggleStyle(SwitchToggleStyle(tint: Color("AccentBlue")))
                }
                .padding(.horizontal)
                if isShowingHour {
                    separator
                    datePickerSection(displayedComponent: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .frame(width: 375, height: 190)
                }
                Spacer()
                AccentButton(name: "Valider", color: .black, action: {
                    presentationMode.wrappedValue.dismiss()
                    hide = true
                })
            }
        }
        .padding(.top)
        .background(Color("lightBlue"))
    }

    @ViewBuilder private var header: some View {
        HStack {
            Text("Echéance")
            Spacer()
            if !isShowingHour {
                Text("\(formatDate(date: date ?? Date(), isIncludingHour: false))")
            } else {
                Text("\(formatDate(date: date ?? Date(), isIncludingHour: true))")
            }
        }
        .padding()
        .padding(.top)
        .font(.footnote)
        .bold()
        .foregroundColor(Color(white: 0.4))
    }

    @ViewBuilder private var separator: some View {
        Divider()
            .foregroundColor(Color(white: 0.4))
            .padding(.horizontal)
    }

    @ViewBuilder private func datePickerSection(displayedComponent: DatePickerComponents) -> some View {
        DatePicker(
            "",
            selection: Binding<Date>(get: { date != nil ? date! : Date() }, set: { date = $0 }),
            displayedComponents: displayedComponent)
        .environment(\.locale, Locale(identifier: "fr_FR"))
        .accentColor(.black)
        .colorScheme(.dark)
        .colorInvert()
        .colorMultiply(Color("AccentBlue"))
    }
}

struct CustomLabel: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color("AccentBlue"))
            Text(title)
                .foregroundColor(.black)
        }
        .padding(.horizontal)
    }
}

struct DatePickerScreen_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerScreen(date: .constant(Date()), isShowingHour: .constant(true), hide: .constant(false))
    }
}
