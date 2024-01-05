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
            if UIDevice.isIPhone{
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
                        Spacer()
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
            if UIDevice.current.userInterfaceIdiom == .pad{
                Image("Backgroundimg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("homepageImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300) // Adjust the width and height as needed
                        .padding(.top, 10)
                    
                    Text("Welcome To")
                        .foregroundStyle(.gray)
                        .font(.system(size: 25))
                    HStack{
                        Image("emoji_a_15")
                            .resizable()
                            .frame(width: 80,height:80)
                        Text("Emoji Mokoko")
                            .bold()
                            .font(.system(size: 25))
                    }
                    if !isFullScreen {
                        VideoPlayer(player: player)
                            .frame(width: 500, height: 350)
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
                        .font(.system(size:20))
                        .padding()
                    
                    HStack{
                        Spacer()
                        VStack(alignment:.leading){
                            
                            Text("1. Click Setup the keyboard")
                            Text("2. Enable the Mokoko keyboard")
                            Text("3. That's it")
                        }
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                        .font(.system(size:25))
                        .padding()
                        
                        Spacer()
                    }
                    
                    Button{
                        
                        openAppSettings()
                        
                    } label:{
                        Text("Setup The Keyboard")
                            .font(.system(size: 20))
                            .frame(width:450,height: 70)
                            .background(.darkBlue)
                            .foregroundStyle(.white)
                            .bold()
                            .cornerRadius(7)
                    }
                    
                    Button{
                        switchScreen = true
                    }label:{
                        Text("Settings")
                            .font(.system(size: 20))
                            .frame(width:450,height: 70)
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
    
}


extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

private func openAppSettings() {
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)


}
