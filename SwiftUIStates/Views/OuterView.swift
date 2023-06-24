//
//  OuterView.swift
//  SwiftUIStates
//
//  Created by Paige Sun on 2023-06-23.
//

import SwiftUI

struct OuterView: View {
    @State private var stateA = 100
    @StateObject private var stateB = Counter(200)
    @StateObject private var stateC = Counter(300)
    @StateObject private var stateD = StringCounter(400)
    @EnvironmentObject private var resetter: ResetObservable
    
    private func resetAll() {
        stateA = 0
        stateB.current = 0
        stateC.current = 0
        stateD.current = "0"
        resetter.needsReset()
    }
    
    var body: some View {
        DrawCounterView("Swift UI State Management") {
            Button("RESET") {
                resetAll()
            }.buttonStyle(.borderedProminent)
            
            HStack {
                Button("🍎 @State var\nstateA: Int = \(stateA)") {
                    stateA += 1
                }.buttonStyle(.borderedProminent)
                
                Button("🐝 @StateObject var\nstateB: Counter = \(stateB.current)") {
                    stateB.current += 1
                }.buttonStyle(.borderedProminent)
                
                Button("🐱 @StateObject var\nstateC: Counter = \(stateC.current)") {
                    stateC.current += 1
                }.buttonStyle(.borderedProminent)
                
                Button("🐶 @StateObject var stateD: \nStringCounter = \"\(stateD.current)\"") {
                    stateD.addOne()
                }.buttonStyle(.borderedProminent)
                
                Spacer()
            }
            
            HStack {
                ViewA("🍎 ViewA(stateA)", myInt: stateA)
                ViewA("ViewA(nil)", myInt: nil)
            }
            HStack {
                ViewB("ViewB()")
                ViewB("ViewB()")
            }
            HStack {
                ViewC("🐱 ViewC(stateC)", stateC: stateC)
                ViewD("🐶 ViewD(stateD)", stateD: stateD)
            }
            HStack {
                ViewE(title: "🍎 ViewE($stateA)",
                      state: $stateA)
                ViewE(title: "🐝 ViewE($stateB.current)",
                      state: $stateB.current)
            }
            HStack {
                ViewE(title: "🐱 ViewE($stateC.current)",
                      state: $stateC.current)
                ViewG(title: "🐶 ViewG($stateD.current)",
                      state: $stateD.current)
            }
            
            ViewH("ViewH()")
        }
        .environmentObject(stateB)
        .onAppear {
            resetAll()
        }
    }
}

struct OuterView_Previews: PreviewProvider {
    static var previews: some View {
        OuterView()
    }
}
