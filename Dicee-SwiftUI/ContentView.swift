//
//  ContentView.swift
//  Dicee-SwiftUI
//
//  Created by Angela Yu on 08/09/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var leftDiceNumber = 1
    @State var rightDiceNumber = 1
    
    @State var isRotated = false
    
    @State private var diceLoaded = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(n: leftDiceNumber, isRotated: $isRotated)
                    DiceView(n: rightDiceNumber, isRotated: $isRotated)
                }
                .padding(.horizontal)
                Spacer()
                Button(action: {
                    if diceLoaded {
                        self.leftDiceNumber = Int.random(in: 5...6)
                        self.rightDiceNumber = Int.random(in: 5...6)
                    } else {
                        self.leftDiceNumber = Int.random(in: 1...6)
                        self.rightDiceNumber = Int.random(in: 1...6)
                    }
                    isRotated.toggle()
                    diceLoaded = false
                }) {
                    Text("Roll")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
                Rectangle()
                    .frame(height: 100)
                    .opacity(0.001)
                    .onTapGesture {
                        //load the dice
                        print ("dice loaded")
                        diceLoaded = true
                    }
            }
        }
    }
}

struct DiceView: View {
    
    let n: Int
    @Binding var isRotated: Bool
    
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
            .rotation3DEffect(Angle.degrees(isRotated ? 1800 : 0), axis: (x:1, y:0, z:0))
            .rotationEffect(Angle.degrees(isRotated ? 1800 : 0))
            .animation(Animation.easeOut(duration: 2), value: isRotated)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

