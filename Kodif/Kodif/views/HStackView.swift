////
////  HStackView.swift
////  Codif
////
////  Created by Izzat on 15.06.2021.
////
//
//import SwiftUI
//
//struct HStackView: View {
//    private var widget: Widget!
//    private var viewModel: ContentViewModel!
//    
//    init(widget: Widget, viewModel: ContentViewModel) {
//        self.widget = widget
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        HStack {
//            ForEach(0..<widget.views!.count) { idx in
//                let view = self.widget.views![idx]
//                switch view.type {
//                case "Image":
//                    ImageView(viewW: view)
//                case "Text":
//                    TextView(viewW: view)
//                case "Spacer":
//                    Spacer()
//                case "NavigationLink":
//                    Button(action: {
//                        self.viewModel.userInputs[view.key ?? ""] = view.action
//                    }) {
//                        TextView(viewW: view).frame(maxWidth: .infinity)
//                    }
//                    NavigationLink(destination: ContentView(isChild: true, userInputs: viewModel.userInputs), isActive: Binding(
//                                    get: {
//                                        return self.viewModel.userInputs[view.key ?? ""] == view.action
//                                    },
//                                    set: { newValue in
//                                        return self.viewModel.userInputs[view.key ?? ""] = ""
//                                    })) { }
//                case "TextField":
//                    TextFieldView(viewW: view, binding: Binding(
//                                    get: {
//                                        return (self.viewModel.userInputs[view.key!] ?? "")
//                                    },
//                                    set: { newValue in
//                                        return self.viewModel.userInputs[view.key!] = newValue
//                                    }))
//                case "Toggle":
//                    ToggleView(viewW: view)
//                case "Rating":
//                    RatingView(rating: Binding(
//                                get: {
//                                    return Int(self.viewModel.userInputs[view.key!] ?? "0") ?? 0
//                                },
//                                set: { newValue in
//                                    return self.viewModel.userInputs[view.key!] = "\(newValue)"
//                                }))
//                default:
//                    EmptyView()
//                }
//            }
//        }
//        .opacity(Double(widget.view.opacity ?? 1))
//        .setPadding(widget.view.padding)
//        .setBackground(widget.view.background)
//        .frame(maxWidth: .infinity)
//    }
//}
