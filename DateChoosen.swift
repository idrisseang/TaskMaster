//
//  DateChoosen.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 12/04/2023.
//

import SwiftUI

struct DateChoosen: View {
   @Binding var date : Date?
    let isShowingHour : Bool
    let onClick : () -> Void
    
    func formatDate(date:Date,isIncludingHour : Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        if isIncludingHour {
            dateFormatter.dateFormat = "EEE d MMMM YYYY 'à' HH:mm"
        } else {
            dateFormatter.dateFormat = "EEE d MMMM YYYY"
        }
        let dateFormatted = dateFormatter.string(from: date)
        return dateFormatted
    }
    
    var body: some View {
        HStack(spacing:4){
            Text(formatDate(date:date ?? Date(),isIncludingHour: isShowingHour))
                .font(.footnote)
                .bold()
                .foregroundColor(.white)
            Text("|")
                .foregroundColor(Color.white)
                .opacity(0.4)
                .font(.footnote)
                .fontWeight(.light)
            Button {
                onClick()
            } label: {
                Image(systemName: "multiply")
                    .font(.footnote)
                    .foregroundColor(Color.white)
            }
        }
        .padding(4)
        .background(Color("AccentBlue"))
        .cornerRadius(4)
    }
}

struct DateChoosen_Previews: PreviewProvider {
    static var previews: some View {
        DateChoosen(date: .constant(Date()), isShowingHour: true,onClick: {})
            .previewLayout(.sizeThatFits)
            .padding()
            .background(.white)
    }
}
