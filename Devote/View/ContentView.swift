//
//  ContentView.swift
//  Devote
//
//  Created by Labhesh Dudi on 18/12/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    
    @State var task: String = ""
    
    // FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - FUNCTIONS
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    List {
                        ForEach(items) { item in
                            VStack(alignment: .leading) {
                                Text(item.task ?? "")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    } //: LIST
                    .scrollContentBackground(.hidden)
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } //: VSTACK
            } //: ZStack
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                #endif
            } //: TOOLBAR
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
