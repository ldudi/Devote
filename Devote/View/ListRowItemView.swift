//
//  ListRowItemView.swift
//  Devote
//
//  Created by Labhesh Dudi on 27/12/25.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : .primary)
                .padding(.vertical, 12)
                .animation(.default)
        } //: TOGGLE
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

#Preview {
    ListRowItemView(item: Item(context: .init()))
}
