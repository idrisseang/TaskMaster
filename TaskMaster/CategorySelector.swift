//
//  CategorySelector.swift
//  TrackMaster
//
//  Created by Idrisse Angama on 08/04/2023.
//

import SwiftUI

struct CategorySelector: View {
    let categoriesImages = Category.allCases
    @Binding var selectedCategories : [String]
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach (categoriesImages, id: \.self) { category in
                    Button{
                        if selectedCategories.contains(category.rawValue) {
                            selectedCategories.removeAll(where: { $0 == category.rawValue })
                        } else {
                            selectedCategories.append(category.rawValue)
                        }
                    } label: {
                        Circle()
                            .frame(width: 65,height: 65)
                            .foregroundColor(selectedCategories.contains(category.rawValue) ? Color("AccentBlue") .opacity(0.5) : .white)
                            .overlay{
                                Image(category.rawValue)
                                    .resizable()
                                    .frame(width: 40,height: 40)
                            }
                    }
                }
            }
        }
    }
}

struct CategorySelector_Previews: PreviewProvider {
    @State static var previewSelectedCategories = ["all","house"]
    static var previews: some View {
        CategorySelector(selectedCategories: $previewSelectedCategories)
            .padding(.vertical)
            .background(Color("lightBlue"))
            .previewLayout(.sizeThatFits)
    }
}
