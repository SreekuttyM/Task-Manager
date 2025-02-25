//
//  ContentView.swift
//  TaskManagerApp
//
//  Created by Sreekutty Maya on 25/02/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(TImage.appLogo.rawValue)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!").font(.custom("Poppins-Bold", fixedSize: 12))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
