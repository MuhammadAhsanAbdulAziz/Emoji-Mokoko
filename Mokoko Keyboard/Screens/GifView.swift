import SwiftUI
import SwiftGifOrigin

struct GifView: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()

        guard let gifData = loadData() else {
            print("Error loading GIF data")
            return imageView
        }

        do {
            let gifImage = try UIImage(gifData: gifData)
            imageView.setGifImage(gifImage)
        } catch {
            print("Error creating GIF image: \(error)")
        }

        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        // No need to update for a static image
    }

    private func loadData() -> Data? {
        guard let gifPath = Bundle.main.path(forResource: name, ofType: "gif") else {
            print("GIF file not found")
            return nil
        }

        return FileManager.default.contents(atPath: gifPath)
    }
}
