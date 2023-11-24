//
//  TheacherList.swift
//  SwiftBookApp
//
//  Created by Roman Khancha on 18.11.2023.
//

import SwiftUI

struct TheacherList: View {
    var body: some View {
        NavigationView {
            List(userResponse) { user in
                Cell(user: user)
            }
            .navigationTitle("Teacher")
        }
        .dynamicTypeSize(.small)
    }
}

struct TheacherList_Previews: PreviewProvider {
    static var previews: some View {
        TheacherList()
    }
}
