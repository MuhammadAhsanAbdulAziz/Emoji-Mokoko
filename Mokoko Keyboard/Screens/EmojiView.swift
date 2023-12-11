//
//  EmojiView.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 21/11/2023.
//

import SwiftUI

struct EmojiView: View {
    
    var image: String
    
    var body: some View {
            Image(image)
                .resizable()
                .frame(width:35,height:35)
    }
}

