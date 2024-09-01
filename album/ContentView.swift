//
//  ContentView.swift
//  album
//
//  Created by Luke Whrit on 9/1/24.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
}

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    let appwrite = Appwrite()

    var body: some View {
        VStack {
            TextField(
                "Email",
                
                text: $viewModel.email
            )
            SecureField(
                "Password",
                text: $viewModel.password
            )
            Button(
                action: { Task {
                    try await appwrite.onRegister(
                        viewModel.email,
                        viewModel.password
                    )
                }},
                label: {
                    Text("Register")
                }
            )
            Button(
                action: { Task {
                    try! await appwrite.onLogin(
                        viewModel.email,
                        viewModel.password
                    )
                }},
                label: {
                    Text("Login")
                }
            )
        }
        .padding()
    }
}
