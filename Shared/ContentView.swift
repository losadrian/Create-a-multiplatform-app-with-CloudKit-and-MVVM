import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contentViewModel.items) { item in
                    NavigationLink {
                        Text("Item at \(item.creationTime!, formatter: itemFormatter)")
                    } label: {
                        Text(item.creationTime!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: contentViewModel.deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: contentViewModel.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .animation(.default, value: contentViewModel.items)
#if os(iOS)
        .navigationViewStyle(.stack)
#endif
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
        ContentView()
    }
}
