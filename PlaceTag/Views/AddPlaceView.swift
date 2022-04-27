import SwiftUI

struct AddPlaceView: View {
	@State private var title: String = ""
	@State private var note: String = ""
	@State private var image: UIImage?
	@State private var shouldShowImagePicker = false

	@Environment(\.managedObjectContext) private var viewContext
	@Environment(\.presentationMode) private var presentationMode

	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			Form {
				Section(header: Text("Title")) {
					TextField("Insert place title here", text: $title)
						.autocapitalization(.words)
				}

				Section(header: Text("Notes")) {
					TextField("Insert notes about the place here", text: $note)
						.autocapitalization(.sentences)
				}

				Section {
					Button(
						action: {
							shouldShowImagePicker.toggle()
						},
						label: makeImageForChoosePhotosButton
					)
				}
			}

			Button(
				action: {
					Place.create(title: title, note: note, image: image, context: viewContext)
					presentationMode.wrappedValue.dismiss()
				},
				label: {
					HStack {
						Image(systemName: "square.and.arrow.down.fill")
						Text("Save Place")
					}
				}
			)
			.buttonStyle(ActionButtonBackgroundStyle())
		}
		.navigationBarTitle("Add Place")
		.sheet(isPresented: $shouldShowImagePicker) {
			ImagePicker(image: $image)
		}
	}

	@ViewBuilder
  private func makeImageForChoosePhotosButton() -> some View {
		image.map {
			Image(uiImage: $0)
				.renderingMode(.original)
				.resizable()
				.aspectRatio(contentMode: .fill)
		}

		if image == nil {
			HStack {
				Spacer()
				Image(systemName: "photo.on.rectangle")
				Text("Choose Photo")
				Spacer()
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		}
	}
}

struct AddPlaceView_Previews: PreviewProvider {
	static var previews: some View {
		AddPlaceView()
	}
}
