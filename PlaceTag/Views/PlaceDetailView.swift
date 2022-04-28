import SwiftUI

struct PlaceDetailView: View {
	let title: String?
	let subtitle: String?
	let image: UIImage?
  let feeling: String?

	var body: some View {
		ScrollView {
			VStack {
				image.map {
					Image(uiImage: $0)
						.renderingMode(.original)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.cornerRadius(8)
						.shadow(radius: 10)
				}
				title.map {
					Text($0)
						.font(.largeTitle)
				}
				subtitle.map {
					Text($0)
						.font(.title)
						.foregroundColor(.secondary)
				}
        feeling.map {
          Text($0)
            .font(.body)
            .foregroundColor(.secondary)
        }
			}
			.multilineTextAlignment(.center)
			.padding()
		}
		.navigationBarTitle(Text(""), displayMode: .inline)
	}
}

struct PlaceDetailView_Previews: PreviewProvider {
	static var previews: some View {
		PlaceDetailView(
			title: "San Francisco",
			subtitle: "Golden Gate was awesome",
      image: UIImage(systemName: "photo"),
      feeling: "I was happy today"
		)
	}
}
