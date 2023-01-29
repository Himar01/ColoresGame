//
//  TopListView.swift
//  Colores
//
//  Created by alumno on 23/11/22.
//

import SwiftUI
struct TopListView: View {

    var body: some View {
            VStack{
                Text("Top Tier List")
                    .font(.system(size:20))
                List(ColoresApp.winners, id: \.id){
                    winner in
                    RowView(user: winner)
                    
                }
                
            }
    }
}

struct TopListView_Previews: PreviewProvider {
    static var previews: some View {
        TopListView().previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
    }
}
