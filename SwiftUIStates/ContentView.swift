//
//  ContentView.swift
//  SwiftUIStates
//
//  Created by Paige Sun on 2023-06-23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var resetter = ResetObservable(false)
    
    var body: some View {
        ScrollView {
            OuterView()
        }
        .font(.system(size: 15)).foregroundColor(.white)
        .environmentObject(resetter)
        .frame(alignment: .topLeading)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
