//
//  LegitGrailsLogo.swift
//  LegitGrails
//
//  Created by Georgy Polonskiy on 29/11/2021.
//

import SwiftUI

struct LegitGrailsLogo: View {
    var body: some View {
        Image("LegitGrails")
            .resizable()
            .frame(width: 100, height: 75)
    }
}

struct LegitGrailsLogo_Previews: PreviewProvider {
    static var previews: some View {
        LegitGrailsLogo()
    }
}
