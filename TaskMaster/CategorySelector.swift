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
    @Binding var selectedCategory : String
    @Binding var isTaskCreationScreen : Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach (categoriesImages, id: \.self) { category in
                    Button{
                        if (isTaskCreationScreen) {
                            selectedCategory = category.rawValue
                        } else {
                            if selectedCategories.contains(category.rawValue) || selectedCategory == category.rawValue {
                                selectedCategories.removeAll(where: { $0 == category.rawValue })
                            } else {
                                selectedCategories.append(category.rawValue)
                            }
                        }
                    } label: {
                        Circle()
                            .frame(width: 65,height: 65)
                            .foregroundColor(selectedCategories.contains(category.rawValue) || selectedCategory == category.rawValue ? Color("AccentBlue") .opacity(0.5) : .white)
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
    @State static private var previewSelectedCategories = ["all","house"]
    @State static private var previewSelectedCategory = "workout"
    static var previews: some View {
        CategorySelector(selectedCategories: $previewSelectedCategories, selectedCategory: $previewSelectedCategory, isTaskCreationScreen: .constant(true))
            .padding(.vertical)
            .background(Color("lightBlue"))
            .previewLayout(.sizeThatFits)
    }
}
