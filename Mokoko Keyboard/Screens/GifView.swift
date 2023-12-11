import SwiftUI

struct GifView: View {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    var body: some View {
        if let gifImage = UIImage(gif: name) {
            Image(uiImage: gifImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Text("Error loading GIF")
        }
    }
}

extension UIImage {
    convenience init?(gif name: String) {
        guard let gifPath = Bundle.main.path(forResource: name, ofType: "gif"),
              let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) else {
            return nil
        }

        self.init(data: gifData)
    }
}
