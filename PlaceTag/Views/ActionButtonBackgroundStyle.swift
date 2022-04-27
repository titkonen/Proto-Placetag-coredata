import SwiftUI

struct ActionButtonBackgroundStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.padding()
			.foregroundColor(.white)
			.background(Color.accentColor)
			.clipShape(Capsule())
			.padding([.horizontal])
			.shadow(radius: configuration.isPressed ? 2.0 : 6.0)
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
	}
}
