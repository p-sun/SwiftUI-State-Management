//
//  ViewAB.swift
//  SwiftUIStates
//
//  Created by Paige Sun on 2023-06-23.
//

import SwiftUI
struct ViewAB: View {
    private let title: String
    // Cannot mutate this w/o @State, since struct is immutable
    private let stateA: Int?
    @EnvironmentObject private var stateB: Counter
    @State private var forceUpdate: Int = 0

    init(_ title: String, stateA: Int?) {
        self.title = title
        self.stateA = stateA
    }
    
    var body: some View {
        DrawCounterView(title) {
            let stateAStr = "let stateA = \(stateA != nil ? String(stateA!) : "nil")"
            Text(stateAStr)
            Button("🐝 @EnvironmentObject var stateB = \(stateB.current)") {
                stateB.current += 1
            }.buttonStyle(.borderedProminent)

            Button("Update \(forceUpdate)") {
                forceUpdate += 1
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct ViewC: View {
    private let title: String
    @ObservedObject private var stateC: Counter

    init(_ title: String, stateC: Counter) {
        self.title = title
        self.stateC = stateC
    }
    
    var body: some View {
        DrawCounterView(title) {
            Button("🐱 @ObservedObject var stateC = \(stateC.current)") {
                stateC.current += 1
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct ViewD: View {
    private let title: String
    @ObservedObject private var stateD: StringCounter

    init(_ title: String, stateD: StringCounter) {
        self.title = title
        self.stateD = stateD
    }
    
    var body: some View {
        DrawCounterView(title) {
            Button("🐱 @ObservedObject var stateD = \"\(stateD.current)\"") {
                stateD.current = String(Int(stateD.current)! + 1)
            }.buttonStyle(.borderedProminent)
        }
    }
}


struct ViewE: View {
    let title: String
    @Binding var state: Int

    var body: some View {
        DrawCounterView(title) {
            Button("@Binding var stateE: Int = \(state)") {
                state = $state.wrappedValue + 1
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct ViewG: View {
    let title: String
    @Binding var state: String

    var body: some View {
        DrawCounterView(title) {
            Button("@Binding var stateG: String = \"\(state)\"") {
                state = String(Int($state.wrappedValue)! + 1)
            }.buttonStyle(.borderedProminent)
        }
    }
}


struct ViewH: View {
    private let title: String
    @ObservedObject private var stateG = Counter()
    @State private var forceUpdate: Int = 0
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        DrawCounterView(title + "\nstateG = Counter()") {
            Button("🦒 @ObservedObject var stateG = \(stateG.current)") {
                stateG.current += 1
            }.background(.secondary).buttonStyle(.bordered)
            
            Button("Update \(forceUpdate)") {
                forceUpdate += 1
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct InnerView_Previews: PreviewProvider {
    static var previews: some View {
        ViewAB("ViewAB", stateA: 9).environmentObject(Counter())
    }
}
