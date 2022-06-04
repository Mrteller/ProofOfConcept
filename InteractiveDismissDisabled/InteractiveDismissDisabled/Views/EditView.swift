//
//  EditView.swift
//  InteractiveDismissDisabled
//
//  Created by Paul on 04.06.2022.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var user: User
    
    @StateObject private var viewModel: EditViewModel
    @State var showingConfirmationDialog = false
    
    init(user: Binding<User>) {
        self._user = user
        self._viewModel = StateObject(wrappedValue: EditViewModel(user: user.wrappedValue))
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter your first name", text: $viewModel.user.firstName)
                TextField("Enter your second name", text: $viewModel.user.secondName)
            }
            .navigationTitle("Edit")
            .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled(viewModel.isModified) {
            showingConfirmationDialog.toggle()
        }
        .confirmationDialog("", isPresented: $showingConfirmationDialog) {
            Button("Save") {
                user = viewModel.user
                dismiss()
            }
            Button("Discard", role: .destructive) {
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}


struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(user: .constant(User()))
    }
}
