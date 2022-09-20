//
//  ShareSheetView.swift
//  ShareSheetInMenu
//
//  Created by Paul on 20.09.2022.
//

import SwiftUI

struct ShareSheetView: View {
    @State private var isShowingPopover = false
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                
                Button("Show Popover") {
                    isShowingPopover = true
                }
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingPopover.toggle()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .uiKitPopover(isPresented: $isShowingPopover) {
                        VStack {
                            ShareLink(
                                item: URL(string: "https://www.apple.com")!,
                                preview: SharePreview(
                                    "Test 123",
                                    image: Image(systemName: "plus")
                                )
                            )
                            Divider()
                            ShareLink(
                                item: URL(string: "https://www.microsoft.com")!,
                                preview: SharePreview(
                                    "Tests 321",
                                    image: Image(systemName: "minus")
                                )
                            )
                        }
                        .fixedSize()
                        .padding()
                    }
                }
            }
        }
    }
}

struct ShareSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheetView()
    }
}

struct PopoverViewModifier<PopoverContent>: ViewModifier where PopoverContent: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let content: () -> PopoverContent
    let permittedArrowDirections: UIPopoverArrowDirection = []
    
    func body(content: Content) -> some View {
        content
            .background(
                Popover(
                    isPresented: $isPresented,
                    onDismiss: onDismiss,
                    content: self.content
                )
            )
    }
}

struct Popover<Content: View> : UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    @ViewBuilder let content: () -> Content
    let permittedArrowDirections: UIPopoverArrowDirection = []
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, content: self.content())
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        context.coordinator.host.rootView = self.content()
        if self.isPresented, uiViewController.presentedViewController == nil {
            let host = context.coordinator.host
            host.preferredContentSize = host.sizeThatFits(in: CGSize(width: Int.max, height: Int.max))
            host.modalPresentationStyle = UIModalPresentationStyle.popover
            host.popoverPresentationController?.delegate = context.coordinator
            host.popoverPresentationController?.sourceView = uiViewController.view
            host.popoverPresentationController?.sourceRect = uiViewController.view.bounds
            host.popoverPresentationController?.permittedArrowDirections = permittedArrowDirections
            uiViewController.present(host, animated: true, completion: nil)
        }
    }
    
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        let host: UIHostingController<Content>
        private let parent: Popover
        
        init(parent: Popover, content: Content) {
            self.parent = parent
            self.host = UIHostingController(rootView: content)
        }
        
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            self.parent.isPresented = false
            if let onDismiss = self.parent.onDismiss {
                onDismiss()
            }
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
    }
}

extension View {
    func uiKitPopover<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, content: @escaping () -> Content) -> some View where Content: View {
        self.modifier(PopoverViewModifier(isPresented: isPresented, onDismiss: onDismiss, content: content))
    }
}
