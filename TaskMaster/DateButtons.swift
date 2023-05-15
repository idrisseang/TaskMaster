//
//  DateButtons.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 15/05/2023.
//

import SwiftUI

struct DateButtons: View {
    var body: some View {
        Text("")
    }
}
struct DateButtonsSection: View {
    let isInSelectionMode: Binding<Bool>
    let hide: Binding<Bool>
    let date: Binding<Date?>
    let isShowingHour: Binding<Bool>
    let isShowingDatePickerScreen: Binding<Bool>

    var body: some View {
        HStack {
            if isInSelectionMode.wrappedValue && !hide.wrappedValue {
                DatePickerButton(
                    title: "Aujourd'hui",
                    timeVariation: .day,
                    value: 0,
                    iconName: "sun.max",
                    currentDate: date, hide: hide) {
                        withAnimation {
                            hide.wrappedValue = true
                            isShowingHour.wrappedValue = false
                        }
                    }
                DatePickerButton(
                    title: "Demain",
                    timeVariation: .day,
                    value: 1,
                    iconName: "sunrise",
                    currentDate: date, hide: hide) {
                        withAnimation {
                            hide.wrappedValue = true
                            isShowingHour.wrappedValue = false
                        }
                    }
                DatePickerButton(
                    title: "Dans 1h",
                    timeVariation: .hour,
                    value: 1,
                    iconName: "hourglass",
                    currentDate: date, hide: hide) {
                        withAnimation {
                            hide.wrappedValue = true
                            isShowingHour.wrappedValue = true
                        }
                    }
                DatePickerButton(
                    title: "Date et Heure",
                    timeVariation: .day,
                    value: 0,
                    iconName: "calendar.badge.clock",
                    currentDate: date, hide: hide) {
                        isShowingDatePickerScreen.wrappedValue = true
                    }
            } else {
                DateChoosen(date: date.wrappedValue ?? Date(), isShowingHour: isShowingHour) {
                    withAnimation {
                        hide.wrappedValue = false
                    }
                    date.wrappedValue = Date()
                }
            }
        }
    }
}
struct DateButtons_Previews: PreviewProvider {
    static var previews: some View {
        DateButtons()
    }
}
