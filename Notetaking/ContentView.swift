//
//  ContentView.swift
//  Notetaking
//
//  Created by Brenda Saavedra  on 26/04/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NoteEntry.createdAt, ascending: true)],
        animation: .default)
    private var items: FetchedResults<NoteEntry>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    if let title = item.title,
                       let content = item.content,
                       let updatedAt = item.updatedAt {
                        NavigationLink {
                            Text(content)
                        } label: {
                            Text(title)
                            Text(updatedAt, formatter: itemFormatter)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: PersistenceController.shared.addNoteEntry) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select a note")
        }
    }

    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
