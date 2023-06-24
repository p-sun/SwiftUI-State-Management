//
//  DrawCounter.swift
//  SwiftUIStates
//
//  Created by Paige Sun on 2023-06-23.
//

import SwiftUI

fileprivate class DrawCounter: ObservableObject {
    var current: Int = 0
}

class ResetObservable: ObservableObject, Equatable {
    @Published var current: Bool = false
        
    func sendReset() {
        print("ResetObservable sendReset()")
        self.current = !current
    }
    
    static func == (lhs: ResetObservable, rhs: ResetObservable) -> Bool {
        lhs.current == rhs.current
    }
}

struct DrawCounterView<Content>: View where Content: View {    
    @StateObject private var counter = DrawCounter()
    @ViewBuilder private let content: Content
    @EnvironmentObject private var resetter: ResetObservable

    private let title: String

    @inlinable public init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        let _ = counter.current += 1
        let h = Double(counter.current) / 10.0 + 0.2;
        let color = Color(hue: h, saturation: 0.7, brightness: 0.4)

        VStack(alignment: .leading) {
            Text(title).bold()
            Text("Draws: \(counter.current)")
            content
        }
        .onReceive(resetter.$current) { _ in
            counter.current = 0
        }
        .padding()
        .border(.black, width: 6)
        .background(color)
    }
}

struct DrawCounter_Previews: PreviewProvider {
    static var previews: some View {
        DrawCounterView("Preview"){}
    }
}
