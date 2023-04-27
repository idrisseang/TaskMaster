//
//  formatDate.swift
//  TaskMaster
//
//  Created by Idrisse Angama on 27/04/2023.
//

import Foundation

public func formatDate(date : Date, isIncludingHour : Bool) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "fr_FR")
    dateFormatter.dateFormat = isIncludingHour ? "EEE d MMMM YYYY 'à' HH:mm" : "EEE d MMMM YYYY"
    let dateFormatted = dateFormatter.string(from: date)
    return dateFormatted
}
