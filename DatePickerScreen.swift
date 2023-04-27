//
//  DatePickerScreen.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 12/04/2023.
//

import SwiftUI

struct DatePickerScreen: View {
    @Environment (\.presentationMode) var presentationMode
    @Binding var date : Date?
    @FocusState private var isFocused : Bool
    @State private var isOn : Bool = false
    @Binding var hide : Bool
    
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
        VStack{
            HStack{
                Text("Echéance")
                Spacer()
                if !isOn{
                    Text("\(formatDate(date:date ?? Date(),isIncludingHour:false))")
                }else{
                    Text("\(formatDate(date:date ?? Date(),isIncludingHour:true))")
                }
            }
            .padding()
            .padding(.top)
            .font(.footnote)
            .bold()
            .foregroundColor(Color(white:0.4))
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "calendar")
                        .foregroundColor(Color("AccentBlue"))
                    Text("Date")
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                Divider()
                    .foregroundColor(Color(white:0.4))
                    .padding(.horizontal)
                if let unwrappedDate = date {
                    DatePicker("", selection: Binding<Date>(get: { unwrappedDate }, set: { date = $0 }), displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "fr_FR"))
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .accentColor(.black)
                        .colorScheme(.dark)
                        .colorInvert()
                        .colorMultiply(Color("AccentBlue"))
                } else {
                    DatePicker("", selection: Binding<Date>(get: { Date() }, set: { date = $0 }), displayedComponents: .date)
                        .environment(\.locale, Locale(identifier: "fr_FR"))
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .accentColor(.black)
                        .colorScheme(.dark)
                        .colorInvert()
                        .colorMultiply(Color("AccentBlue"))
                }
                Divider()
                    .foregroundColor(Color(white:0.4))
                    .padding(.horizontal)
                HStack{
                    Image(systemName: "clock")
                        .foregroundColor(Color("AccentBlue"))
                    Text("Heure")
                        .foregroundColor(.black)
                    Toggle("", isOn: $isOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color("AccentBlue")))
                }
                .padding(.horizontal)
                
                if isOn {
                    Divider()
                        .foregroundColor(Color(white:0.4))
                        .padding(.horizontal)
                    VStack(alignment: .center) {
                        if let unwrappedDate = date {
                            DatePicker("", selection: Binding<Date>(get: { unwrappedDate }, set: { date = $0 }),displayedComponents: .hourAndMinute)
                                .datePickerStyle(.wheel)
                                .environment(\.locale, Locale(identifier: "fr_FR"))
                                .frame(width: 375,height: 190)
                                .accentColor(.black)
                                .colorScheme(.dark)
                                .colorInvert()
                                .colorMultiply(Color("AccentBlue"))
                        } else {
                            DatePicker("", selection: Binding<Date>(get: { Date() }, set: { date = $0 }), displayedComponents: .hourAndMinute)
                                .datePickerStyle(.wheel)
                                .environment(\.locale, Locale(identifier: "fr_FR"))
                                .frame(width: 375,height: 190)
                                .accentColor(.black)
                                .colorScheme(.dark)
                                .colorInvert()
                                .colorMultiply(Color("AccentBlue"))
                        }
                    }
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
}

struct DatePickerScreen_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerScreen(date: .constant(Date()), hide: .constant(false))
    }
}
