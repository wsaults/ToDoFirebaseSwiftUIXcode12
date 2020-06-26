//
//  SignInView.swift
//  ToDoFirebase
//
//  Created by Will Saults on 6/24/20.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var coordinator: SignInWithAppleCoordinator?
    
    var body: some View {
        VStack {
            Text("Thanks for using this ToDo App. Please sign in here.")
            SignInWithAppleButton()
                .frame(width: 280, height: 45)
                .onTapGesture {
                    self.coordinator = SignInWithAppleCoordinator()
                    if let coordinator = self.coordinator {
                    coordinator.startSignInWithAppleFlow {
                        print("You succesfully signed in")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
