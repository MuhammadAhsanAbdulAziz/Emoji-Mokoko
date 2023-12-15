//
//  Homepage.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 20/11/2023.
//

import SwiftUI
import AVKit

struct Homepage: View {
    
    @State var switchScreen = false
    @State private var player = AVPlayer()
    @State private var isFullScreen = false
    
    
    var body: some View {
        ZStack{
            Image("Backgroundimg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("homepageImage")
                    .padding(.top,10)
                
                Text("Welcome To")
                    .foregroundStyle(.gray)
                HStack{
                    Image("emoji_a_15")
                        .resizable()
                        .frame(width: 50,height:50)
                    Text("Emoji Mokoko")
                        .bold()
                }
                if !isFullScreen {
                    VideoPlayer(player: player)
                        .frame(width: 300, height: 250)
                        .onAppear {
                            guard let videoURL = Bundle.main.url(forResource: "Video", withExtension: "mov") else { return }
                            player = AVPlayer(url: videoURL)
                            player.play()
                            
                            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { _ in
                                player.seek(to: .zero)
                                player.play()
                            }
                        }
                        .onDisappear {
                            player.pause()
                        }
                        .onTapGesture {
                            isFullScreen.toggle()
                        }
                } else {
                    FullScreenVideoPlayer(player: player)
                        .frame(width: 300, height: 250)
                        .onDisappear {
                            isFullScreen = false
                        }
                }
                
                Text("Watch The Setup Tutorial Video")
                    .bold()
                    .font(.system(size:12))
                    .padding()
                
                HStack{
                    
                    VStack(alignment:.leading){
                        
                        Text("1. Click Setup the keyboard")
                        Text("2. Enable the Mokoko keyboard")
                        Text("3. That's it")
                    }
                    .foregroundStyle(.gray)
                    .fontWeight(.light)
                    .font(.system(size:15))
                    .padding()
                    
                    Spacer()
                }
                
                Button{
                    
                    openAppSettings()
                    
                } label:{
                    Text("Setup The Keyboard")
                        .frame(width:350,height: 50)
                        .background(.darkBlue)
                        .foregroundStyle(.white)
                        .bold()
                        .cornerRadius(7)
                }
                
                Button{
                    switchScreen = true
                }label:{
                    Text("Settings")
                        .frame(width:350,height: 50)
                        .background(.darkBlue)
                        .foregroundStyle(.white)
                        .bold()
                        .cornerRadius(7)
                }.sheet(isPresented: $switchScreen) {
                    Settings(isPresented: $switchScreen)
                }
            }
        }
    }
    
}

private func openAppSettings() {
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)


}


#Preview{
    Homepage()
}
