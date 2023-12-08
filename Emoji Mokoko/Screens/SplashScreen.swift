//
//  SplashScreen.swift
//  Emoji Mokoko
//
//  Created by Macbook Pro on 20/11/2023.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var isActive : Bool = false
    
    var body: some View {
        ZStack{
            if self.isActive{
                Homepage()
            }
            else{
                Image("SplashScreen")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5)
            {
                withAnimation{
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
