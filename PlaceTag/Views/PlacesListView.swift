import SwiftUI
import CoreData

struct PlacesListView: View {
	@FetchRequest(entity: Place.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Place.date, ascending: false)])
	private var places: FetchedResults<Place>
	@Environment(\.managedObjectContext) private var viewContext

	var body: some View {
		NavigationView {
			ZStack(alignment: .bottomTrailing) {
				List {
					ForEach(places, id: \.id) { place in
						NavigationLink(destination: makeDetailView(from: place)) {
							makeItemView(from: place)
						}
					}.onDelete(perform: deletePlaces)
				}
				.listStyle(GroupedListStyle())
				.overlay(places.isEmpty ? Text("Add a place using the button below") : nil, alignment: .center)

				NavigationLink(destination: AddPlaceView()) {
					HStack {
						Image(systemName: "plus.circle.fill")
						Text("Add Place")
					}
				}
				.buttonStyle(ActionButtonBackgroundStyle())
			}
			.navigationBarTitle("PlaceTag")
		}
	}

	private func makeDetailView(from place: Place) -> PlaceDetailView {
		return PlaceDetailView(
			title: place.title,
			subtitle: place.note,
			image: place.image?.uiImage)
	}

	private func makeItemView(from place: Place) -> PlaceItemView {
		return PlaceItemView(
			title: place.title,
			subtitle: place.note,
			image: place.image?.uiImage
		)
	}

	private func deletePlaces(at indices: IndexSet) {
		DispatchQueue.main.async {
      var result: [Place] = []
			for index in indices {
				result.append(places[index])
			}
			viewContext.delete(result)
		}
	}
}
