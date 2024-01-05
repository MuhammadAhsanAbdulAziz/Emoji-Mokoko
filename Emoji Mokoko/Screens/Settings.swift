//
//  Settings.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 20/11/2023.
//

import SwiftUI
import AVKit

struct Settings: View {
    
    @State private var isNotiOn = SharedPreferencesManager.shared.getValue(forKey: "noti")
    @State private var isRecentlyOn = SharedPreferencesManager.shared.getValue(forKey: "recently")
    @State private var isThemeOn = SharedPreferencesManager.shared.getValue(forKey: "theme")
    @Binding var isPresented: Bool
    @State private var player = AVPlayer()
    @State private var isFullScreen = false
    
    
    var body: some View {
        ZStack{
            if UIDevice.isIPhone{
                VStack{
                    
                    HStack{
                        Button{
                            isPresented = false
                        }label:{
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        Text("Mokoko Settings")
                        Spacer()
                    }
                    .padding()
                    
                    if !isFullScreen {
                        VideoPlayer(player: player)
                            .frame(width: 350, height: 250)
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
                        .fontWeight(.light)
                        .font(.system(size: 15))
                    
                    HStack{
                        VStack(alignment:.leading){
                            Toggle("Enable Push Notifications", isOn: $isNotiOn)
                                .padding()
                                .toggleStyle(SwitchToggleStyle(tint: .lightGreen))
                                .onChange(of: isNotiOn) { newValue in
                                    SharedPreferencesManager.shared.setValue(value: newValue, forKey: "noti")
                                    
                                }
                            Text("Receive new updates about the keyboard")
                                .foregroundStyle(.gray)
                                .font(.system(size: 13))
                                .padding(.leading,15)
                                .padding(.top,-25)
                        }
                    }
                    
                    HStack{
                        VStack(alignment:.leading){
                            Toggle("Recently used Emojis", isOn: $isRecentlyOn)
                                .padding()
                                .toggleStyle(SwitchToggleStyle(tint: .lightGreen))
                                .onChange(of: isRecentlyOn) { newValue in
                                    SharedPreferencesManager.shared.setValue(value: newValue, forKey: "recently")
                                    if let userDefaults = UserDefaults(suiteName: "group.mokokokeyboar1") {
                                        userDefaults.set(newValue as Bool, forKey: "recently")
                                        userDefaults.synchronize()
                                        print(userDefaults.bool(forKey: "recently"))
                                    }
                                }
                            Text("Show emojis that have been used recently")
                                .foregroundStyle(.gray)
                                .font(.system(size: 13))
                                .padding(.leading,15)
                                .padding(.top,-25)
                            
                        }
                    }
                    
                    //                HStack{
                    //                    VStack(alignment:.leading){
                    //                        Toggle("Enable Theme Mode", isOn: $isThemeOn)
                    //                            .padding()
                    //                            .toggleStyle(SwitchToggleStyle(tint: .lightGreen))
                    //                            .onChange(of: isThemeOn) { newValue in
                    //                                SharedPreferencesManager.shared.setValue(value: newValue, forKey: "theme")
                    //                            }
                    //                        Text("Adapt keyboard color to app used")
                    //                            .foregroundStyle(.gray)
                    //                            .font(.system(size: 13))
                    //                            .padding(.leading,15)
                    //                            .padding(.top,-25)
                    //
                    //                    }
                    //                }
                    
                    HStack{
                        Text("We do not collect any of the data you type in!")
                            .font(.system(size: 10))
                            .foregroundStyle(.gray)
                        Image("emoji_a_19")
                            .resizable()
                            .frame(width:20,height:20)
                    }
                    .padding()
                    
                    Spacer()
                }
                .background(.white)
            }
            if UIDevice.isIPad{
                VStack{
                                    
                                    HStack{
                                        Button{
                                            isPresented = false
                                        }label:{
                                            Image(systemName: "chevron.backward")
                                                .foregroundStyle(.black)
                                        }
                                        Spacer()
                                        Text("Mokoko Settings")
                                            .font(.system(size: 30))
                                        Spacer()
                                    }
                                    .padding()
                                    
                                    if !isFullScreen {
                                        VideoPlayer(player: player)
                                            .frame(width: 350, height: 250)
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
                                        .fontWeight(.light)
                                        .font(.system(size: 25))
                                    
                                    HStack{
                                        VStack(alignment:.leading){
                                            Toggle("Enable Push Notifications", isOn: $isNotiOn)
                                                .padding()
                                                .toggleStyle(SwitchToggleStyle(tint: .lightGreen))
                                                .onChange(of: isNotiOn) { newValue in
                                                    SharedPreferencesManager.shared.setValue(value: newValue, forKey: "noti")
                                                    
                                                }
                                            Text("Receive new updates about the keyboard")
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 18))
                                                .padding(.leading,15)
                                                .padding(.top,-25)
                                        }
                                    }
                                    
                                    HStack{
                                        VStack(alignment:.leading){
                                            Toggle("Recently used Emojis", isOn: $isRecentlyOn)
                                                .padding()
                                                .toggleStyle(SwitchToggleStyle(tint: .lightGreen))
                                                .onChange(of: isRecentlyOn) { newValue in
                                                    SharedPreferencesManager.shared.setValue(value: newValue, forKey: "recently")
                                                    if let userDefaults = UserDefaults(suiteName: "group.mokokokeyboar1") {
                                                        userDefaults.set(newValue as Bool, forKey: "recently")
                                                        userDefaults.synchronize()
                                                        print(userDefaults.bool(forKey: "recently"))
                                                    }
                                                }
                                            Text("Show emojis that have been used recently")
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 18))
                                                .padding(.leading,15)
                                                .padding(.top,-25)
                                            
                                        }
                                    }
                                    
                                    //                HStack{
                                    //                    VStack(alignment:.leading){
                                    //                        Toggle("Enable Theme Mode", isOn: $isThemeOn)
                                    //                            .padding()
                                    //                            .toggleStyle(SwitchToggleStyle(tint: .lightGreen))
                                    //                            .onChange(of: isThemeOn) { newValue in
                                    //                                SharedPreferencesManager.shared.setValue(value: newValue, forKey: "theme")
                                    //                            }
                                    //                        Text("Adapt keyboard color to app used")
                                    //                            .foregroundStyle(.gray)
                                    //                            .font(.system(size: 13))
                                    //                            .padding(.leading,15)
                                    //                            .padding(.top,-25)
                                    //
                                    //                    }
                                    //                }
                                    
                                    HStack{
                                        Text("We do not collect any of the data you type in!")
                                            .font(.system(size: 20))
                                            .foregroundStyle(.gray)
                                        Image("emoji_a_19")
                                            .resizable()
                                            .frame(width:40,height:40)
                                    }
                                    .padding()
                                    
                                    Spacer()
                                }
                                .background(.white)
            }
            
        }
        
    }
}

