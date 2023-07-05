//
//  ShopTab.swift
//  Petto
//
//  Created by Aaron Christopher Tanhar on 05/07/23.
//

import SwiftUI

struct ShopTab: View {
    @Binding var activeType: ShopItemType
    var body: some View {
        Grid {
            GridRow {
                Button("Food") {
                    print("Button pressed!")
                    activeType = .energy
                }
                .font(.caption)
                .buttonStyle(BrownButton(width: 50, height: 6, active: activeType == .energy))
                Button("Fun") {
                    print("Button pressed!")
                    activeType = .fun
                }
                .font(.caption)
                .buttonStyle(BrownButton(width: 50, height: 6, active: activeType == .fun))
                Button("Hygiene") {
                    print("Button pressed!")
                    activeType = .hygiene
                }
                .font(.caption)
                .buttonStyle(BrownButton(width: 50, height: 6, active: activeType == .hygiene))
            }
        }
    }
}

struct ShopTab_Previews: PreviewProvider {
    static var previews: some View {
        @State var type = ShopItemType.energy
        ShopTab(activeType: $type)
    }
}
