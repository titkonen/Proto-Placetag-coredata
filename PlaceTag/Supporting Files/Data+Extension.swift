import UIKit.UIImage

extension Data {
	var uiImage: UIImage? {
		return UIImage(data: self)
	}
}
