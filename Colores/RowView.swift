//
//  RowView.swift
//  Colores
//
//  Created by alumno on 24/11/22.
//

import SwiftUI

struct RowView: View {

    var user: User
    var body: some View {
        HStack{
            user.avatar
                .resizable()
                .frame(width: 70,
                       height:40)
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(user.color)
            VStack(alignment: .leading) {
                Text("Puntuación: \(user.bestValue)")
                    .font(.title2)
                Text(user.name)
                    .font(.subheadline)
                Text(user.date)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(user: User(id: 1,  name: "Himar Moreno Santana", bestValue: 0,avatar: Image(systemName: "flag.2.crossed.fill"),color: .yellow, date: "2022/11/30 10:11"))
            
    }
}
