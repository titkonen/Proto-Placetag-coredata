import SwiftUI

struct PlaceItemView: View {
	let title: String?
	let subtitle: String?
	let image: UIImage?

	var body: some View {
		HStack(spacing: 16) {
			image.map {
				Image(uiImage: $0)
					.renderingMode(.original)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 80, height: 80)
					.cornerRadius(4)
					.padding(.vertical)
			}

			VStack(alignment: .leading) {
				title.map {
					Text($0)
						.font(.headline)
				}
				subtitle.map {
					Text($0)
						.font(.subheadline)
				}
			}
		}
	}
}

struct PlaceItemView_Previews: PreviewProvider {
	static var previews: some View {
		PlaceItemView(
			title: "San Francisco",
			subtitle: "Golden gate was awesome",
			image: UIImage(systemName: "photo")
		)
	}
}
