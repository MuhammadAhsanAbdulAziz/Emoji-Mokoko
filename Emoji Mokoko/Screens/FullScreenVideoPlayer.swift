//
//  FullScreenVideoPlayer.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 30/11/2023.
//

import Foundation
import AVKit
import SwiftUI

struct FullScreenVideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer
    
    class Coordinator: NSObject, UINavigationControllerDelegate {
        var parent: FullScreenVideoPlayer
        
        init(parent: FullScreenVideoPlayer) {
            self.parent = parent
        }
        
        @objc func playerDidFinishPlaying(note: NSNotification) {
            parent.player.seek(to: CMTime.zero)
            parent.player.play()
        }
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.delegate = context.coordinator as? any AVPlayerViewControllerDelegate
        
        controller.addChild(playerController)
        controller.view.addSubview(playerController.view)
        playerController.view.frame = controller.view.frame
        playerController.didMove(toParent: controller)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
