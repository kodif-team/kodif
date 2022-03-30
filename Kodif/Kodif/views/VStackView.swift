////
////  VStackView.swift
////  Codif
////
////  Created by Izzat on 22.06.2021.
////
//
//import SwiftUI
//
//struct VStackView: View {
//    var widget: Widget
//
//    @Binding var userInputs: [String: String]
//    @Binding var naviagete: Bool
//
//    var body: some View {
//        VStack {
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
//                        self.userInputs[widget.view.key ?? ""] = view.action
//                        return naviagete = true
//                    }) {
//                        TextView(viewW: view)
//                    }
//                case "TextField":
//                    TextFieldView(viewW: view, binding: Binding(
//                                    get: {
//                                        return (self.userInputs[view.key!] ?? "")
//                                    },
//                                    set: { newValue in
//                                        return self.userInputs[view.key!] = newValue
//                                    }))
//                case "Toggle":
//                    ToggleView(viewW: view)
//                case "Rating":
//                    RatingView(rating: Binding(
//                                get: {
//                                    return Int(self.userInputs[view.key!] ?? "0") ?? 0
//                                },
//                                set: { newValue in
//                                    return self.userInputs[view.key!] = "\(newValue)"
//                                }))
//                case "List":
//                    ListView(view: view, rows: widget.rows!, action: Binding(
//                                get: {return ""},
//                                set: { newValue in
//                                    self.userInputs[view.key!] = newValue
//                                    return naviagete = true
//                                }))
//                case "CheckBoxView":
//                    CheckBoxView(view: view, checked: Binding(
//                                    get: {
//                                        return Bool(self.userInputs[view.key!] ?? "false") ?? false
//                                    },
//                                    set: { newValue in
//                                        return self.userInputs[view.key!] = "\(newValue)"
//                                    }))
//                case "DisclosureGroup":
//                    DisclosureGroupView(view: view)
//                default:
//                    EmptyView()
//                }
//            }
//        }
//        .overlay(
//                RoundedRectangle(cornerRadius: CGFloat(widget.view.cornerRadius ?? 0))
//                    .stroke(Color(hex: widget.view.borderColor ?? "#cccccc"), lineWidth: CGFloat(widget.view.borderWidth ?? 0))
//            )
//        .opacity(Double(widget.view.opacity ?? 1))
//        .setFrame(widget.view.frame)
//        .setBackground(widget.view.background)
//        .setPadding(widget.view.padding)
//    }
//}
