//
//  KeyboardView.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 21/11/2023.
//

import SwiftUI
import MobileCoreServices
import SwiftyGif
import WebPKit

struct KeyboardView: View {
    @State var isEmojiClicked = false
    @State var isGifClicked = false
    @State var emojiSelected = ""
    @State var showOverlay = false
    @ObservedObject var emojiManager = EmojiManager()
    var body: some View {
        ZStack{
            VStack(alignment:.leading){
                HStack{
                    Image("homepageImage")
                        .resizable()
                        .padding(8)
                        .frame(width: 50,height:50)
                        .background(Color(.lightblue))
                        .cornerRadius(15)
                    if let userDefaults = UserDefaults(suiteName: "group.mokokokeyboar1") {
                        let value1 = userDefaults.bool(forKey: "recently")
                        
                        if value1 {
                            RecentlyUsedEmojis(showOverlay: $showOverlay, emojiManager: emojiManager)
                                .onAppear(perform: {
                                    emojiManager.updateEmojis()
                                })
                        }
                    }
                    
                }
                .padding(4)
                
                Divider().background(.gray)
                
                ScrollView(.horizontal){
                    
                    if !isEmojiClicked && !isGifClicked {
                        emojiListView(showOverlay:$showOverlay,emojiManager: emojiManager)
                    }
                    
                    else if isEmojiClicked
                    {
                        if emojiSelected == ""{
                            emojiListView(showOverlay:$showOverlay,emojiManager: emojiManager)
                        }
                        else if emojiSelected == "emoji_a_07"{
                            let emojiArray = (7...14).map { "emoji_a_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_01"{
                            let emojiArray = (1...6).map { "emoji_a_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_19"{
                            let emojiArray = (15...26).map { "emoji_a_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_1_58"{
                            let emojiArray = (58...61).map { "emoji_a_1_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_27"{
                            let emojiArray = (27...32).map { "emoji_a_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_33"{
                            let emojiArray = (33...40).map { "emoji_a_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_41"{
                            let emojiArray = (41...48).map { "emoji_a_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_49"{
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: specialEmoji())
                        }
                        else if emojiSelected == "emoji_a_59"{
                            let emojiArray = (59...63).map { "emoji_a_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_1_03"{
                            let emojiArray = (3...11).map { "emoji_a_1_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_1_12"{
                            let emojiArray = (12...16).map { "emoji_a_1_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_1_25"{
                            let emojiArray = (25...32).map { "emoji_a_1_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                        else if emojiSelected == "emoji_a_1_33"{
                            let emojiArray = (33...42).map { "emoji_a_1_\(String(format: "%02d", $0))" }
                            selectedEmojiListView(emojiManager: emojiManager, showOverlay:$showOverlay,emojis: emojiArray)
                        }
                    }
                    else if isGifClicked
                    {
                        gifListView(showOverlay:$showOverlay)
                    }
                }
                
                HStack{
                    //                    settingViewButton()
                    emojiViewButton(isClicked: $isEmojiClicked, Gif: $isGifClicked)
                    if isEmojiClicked {
                        CollectionEmojis(emojiSelected:$emojiSelected)
                    }
                    
                    gifViewButton(isClicked: $isGifClicked, Emoji: $isEmojiClicked)
                    
                    Spacer()
                    
                    cancelViewButton(Emoji: $isEmojiClicked, Gif: $isGifClicked,emojiSelected: $emojiSelected)
                }
                .padding(.leading,5)
                .padding(.trailing,5)
                .padding(.bottom,5)
            }
        }
        .background(.iconcolor)
        .overlay{
            ZStack{
                if showOverlay{
                    CustomOverlayView()
                        .onAppear {
                            // Use onAppear to trigger the overlay visibility
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    showOverlay = false
                                }
                            }
                        }
                }
            }
        }
    }
}

func specialEmoji() -> [String] {
    var emojiArray = (49...58).map { "emoji_a_\(String(format: "%02d", $0))" }
    emojiArray += (17...24).map { "emoji_a_1_\(String(format: "%02d", $0))" }
    emojiArray += (43...57).map { "emoji_a_1_\(String(format: "%02d", $0))" }
    
    return emojiArray
}

struct CustomOverlayView: View {
    var body: some View {
        VStack {
            // Your custom overlay content, e.g., an alert-like design
            Text("Sticker has been saved to Clipboard")
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CollectionEmojis: View {
    @Binding var emojiSelected : String
    let rows = [
        GridItem(.fixed(10)),
    ]
    var body: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows:rows,spacing: 10){
                EmojiView(image: "emoji_a_07")
                    .onTapGesture {
                        emojiSelected = "emoji_a_07"
                    }
                EmojiView(image: "emoji_a_01")
                    .onTapGesture {
                        emojiSelected = "emoji_a_01"
                    }
                EmojiView(image: "emoji_a_19")
                    .onTapGesture {
                        emojiSelected = "emoji_a_19"
                    }
                EmojiView(image: "emoji_a_1_58")
                    .onTapGesture {
                        emojiSelected = "emoji_a_1_58"
                    }
                EmojiView(image: "emoji_a_27")
                    .onTapGesture {
                        emojiSelected = "emoji_a_27"
                    }
                EmojiView(image: "emoji_a_33")
                    .onTapGesture {
                        emojiSelected = "emoji_a_33"
                    }
                EmojiView(image: "emoji_a_41")
                    .onTapGesture {
                        emojiSelected = "emoji_a_41"
                    }
                EmojiView(image: "emoji_a_49")
                    .onTapGesture {
                        emojiSelected = "emoji_a_49"
                    }
                EmojiView(image: "emoji_a_59")
                    .onTapGesture {
                        emojiSelected = "emoji_a_59"
                    }
                EmojiView(image: "emoji_a_1_03")
                    .onTapGesture {
                        emojiSelected = "emoji_a_1_03"
                    }
                EmojiView(image: "emoji_a_1_12")
                    .onTapGesture {
                        emojiSelected = "emoji_a_1_12"
                    }
                EmojiView(image: "emoji_a_1_25")
                    .onTapGesture {
                        emojiSelected = "emoji_a_1_25"
                    }
                EmojiView(image: "emoji_a_1_33")
                    .onTapGesture {
                        emojiSelected = "emoji_a_1_33"
                    }
            }
        }
    }
}

func addKey() {
    if let imageData = UIPasteboard.general.data(forPasteboardType: "public.png") {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addKey"), object: imageData)
    }
}

struct emojiListView: View {
    
    @Binding var showOverlay: Bool
    @ObservedObject var emojiManager: EmojiManager
    let rows = [
        GridItem(.fixed(30)),
        GridItem(.fixed(30)),
        GridItem(.fixed(30))
    ]
    
    
    var body: some View {
        LazyHGrid(rows:rows,spacing: 10){
            ForEach(1..<65) { index in
                let name = "emoji_a_\(index < 10 ? "0" : "")\(index)"
                EmojiView(image: name)
                    .onTapGesture {
                        DB_Manager().addEmoji(nameValue: name)
                        emojiManager.updateEmojis()
                        saveToPasteBoard(image: name)
                        showOverlay.toggle()
                        
                    }
                
            }
            ForEach(1..<65) { index in
                let name = "emoji_a_\(index < 10 ? "0" : "")\(index)"
                EmojiView(image: name)
                    .onTapGesture {
                        DB_Manager().addEmoji(nameValue: name)
                        emojiManager.updateEmojis()
                        saveToPasteBoard(image: name)
                        showOverlay.toggle()
                    }
                
            }
        }
        .padding(5)
    }
    
}

struct RecentlyUsedEmojis: View {
    @Binding var showOverlay: Bool
    @ObservedObject var emojiManager: EmojiManager
    let rows = [
        GridItem(.fixed(30)),
    ]
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows:rows,spacing: 10){
                ForEach(emojiManager.emojiModels, id: \.id) { emojiModel in
                    EmojiView(image: emojiModel.name)
                        .onTapGesture {
                            saveToPasteBoard(image: emojiModel.name)
                            showOverlay.toggle()
                        }
                }
                
            }
        }
    }
}

struct selectedEmojiListView: View {
    
    @ObservedObject var emojiManager: EmojiManager
    @Binding var showOverlay: Bool
    
    let rows = [
        GridItem(.fixed(30)),
        GridItem(.fixed(30)),
        GridItem(.fixed(30))
    ]
    
    let emojis: [String]
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows:rows,spacing: 10){
                ForEach(emojis, id: \.self) { emoji in
                    EmojiView(image: emoji)
                        .onTapGesture {
                            DB_Manager().addEmoji(nameValue: emoji)
                            emojiManager.updateEmojis()
                            saveToPasteBoard(image: emoji)
                            showOverlay.toggle()
                        }
                }
            }
        }
    }
}

struct gifListView: View {
    @Binding var showOverlay:Bool
    let rows = [
        GridItem(.fixed(100))
    ]
    
    var body: some View {
        LazyHGrid(rows:rows,alignment:.center,spacing: 10){
            ForEach(1..<4) { index in
                GifView( "transparentgif\(index)")
                    .onTapGesture {
                        let url: NSURL = Bundle.main.url(forResource: "gif\(index)", withExtension: ".gif")! as NSURL
                        let data: NSData = NSData(contentsOf: url as URL)!
                        UIPasteboard.general.setData((data as NSData) as Data, forPasteboardType: "com.compuserve.gif")
                        showOverlay.toggle()
                    }
            }
        }
        .padding(5)
    }
}
struct settingViewButton: View {
    var body: some View {
        Button{
        }label:{
            Image("settingicon")
                .resizable()
                .padding(10)
                .frame(width:35,height:35)
                .background(.white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust the corner radius to match the image
                        .stroke(Color.gray, lineWidth: 0.2)
                        .shadow(color: Color.black.opacity(0.7), radius: 14, x: 1, y: 2)
                )
            
        }
    }
}

struct emojiViewButton: View {
    
    @Binding  var isClicked : Bool
    @Binding  var Gif : Bool
    
    var body: some View {
        Button{
            isClicked.toggle()
            if Gif {
                Gif.toggle()
            }
        }label:{
            Image(isClicked ? "whiteemojiicon" : "emojiicon")
                .resizable()
                .padding(10)
                .frame(width:35,height:35)
                .background(isClicked ? .black : .white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust the corner radius to match the image
                        .stroke(Color.gray, lineWidth: 0.2)
                        .shadow(color: Color.black.opacity(0.7), radius: 14, x: 1, y: 2)
                )
            
        }
    }
}

struct gifViewButton: View {
    
    @Binding  var isClicked : Bool
    @Binding  var Emoji : Bool
    
    var body: some View {
        Button{
            isClicked.toggle()
            if Emoji {
                Emoji.toggle()
            }
        }label:{
            Image(isClicked ? "whitegificon" : "gificon")
                .resizable()
                .padding(10)
                .frame(width:35,height:35)
                .background(isClicked ? .black : .white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust the corner radius to match the image
                        .stroke(Color.gray, lineWidth: 0.2)
                        .shadow(color: Color.black.opacity(0.7), radius: 14, x: 1, y: 2)
                )
            
        }
    }
}

struct cancelViewButton: View {
    
    @Binding var Emoji:Bool
    @Binding var Gif:Bool
    @Binding var emojiSelected : String
    
    var body: some View {
        Button{
            if Emoji{
                Emoji.toggle()
            }
            if Gif{
                Gif.toggle()
            }
            if emojiSelected != ""{
                emojiSelected = ""
            }
            NotificationCenter.default.post(name: Notification.Name("CancelButtonPressed"), object: nil)
        }label:{
            Image("cancelicon")
                .resizable()
                .padding(10)
                .frame(width:40,height:35)
                .background(.white)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust the corner radius to match the image
                        .stroke(Color.gray, lineWidth: 0.2)
                        .shadow(color: Color.black.opacity(0.7), radius: 14, x: 1, y: 2)
                )
            
        }
    }
}

class EmojiManager: ObservableObject {
    @Published var emojiModels: [EmojiModel] = []
    
    func updateEmojis() {
        self.emojiModels = DB_Manager().getEmojis()
    }
}

func saveToPasteBoard(image: String) {
    // Load the image
    guard let originalImage = UIImage(named: image) else {
        print("Error: Unable to load the image")
        return
    }

    // Convert the image to WebP format using WebPKit
    do {
        let webpData = try originalImage.webpData()
        
        // Create a new UIImage from the WebP data
        guard let webpImage = UIImage(webpData: webpData) else {
            print("Error: Unable to create UIImage from WebP data")
            return
        }

        UIPasteboard.general.image = webpImage

        print("Image copied to pasteboard")
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}

