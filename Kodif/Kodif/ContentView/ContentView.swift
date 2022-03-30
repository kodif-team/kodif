//
//  ContentView.swift
//  Codif
//
//  Created by Izzat on 01.06.2021.
//

import SwiftUI
import KustomerChat

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    @ObservedObject var globalViewModel = GlobalData.shared
    
    @State private var stars = 0
    @State private var present = false
    @State private var presentLikeAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    init() {}
    
    init(screen: Screen) {
        viewModel.screen = screen
    }
    
    var body: some View {
        mainView()
            .onAppear {
                if viewModel.screen == nil {
                    viewModel.getData()
                    globalViewModel.userInputs.removeAll()
                }
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text(viewModel.errorText ?? ""), dismissButton: .cancel())
            }.fullScreenCover(isPresented: $present) {
                ZStack(alignment: .bottomTrailing) {
                    ContentView()
                    Text("powered by kodif")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 12))
                        .opacity(0.5)
                        .padding()
                }
            }
            .fullScreenCover(isPresented: $presentLikeAlert) {
                ContentAlert()
            }
    }
    
    @ViewBuilder fileprivate func mainView() -> some View {
        if let goBack = viewModel.screen?.config?.goBack,
           goBack {
            ZStack(alignment: .topLeading) {
                rootViewWithActions()
            }
        } else {
            rootViewWithActions()
        }
    }
    
    @ViewBuilder fileprivate func rootViewWithActions() -> some View {
        if viewModel.screen?.action?.actionType != nil{
            rootViewWithParams()
                .onTapGesture {
                    action(screen: viewModel.screen)
                }
        } else {
            rootViewWithParams()
        }
    }
    
    @ViewBuilder fileprivate func rootViewWithParams() -> some View {
        rootView()
            .setPadding(viewModel.screen?.style?.platformStyle?.ios?.style?.padding)
            .setFrame(width: viewModel.screen?.style?.platformStyle?.ios?.style?.width,
                      height: viewModel.screen?.style?.platformStyle?.ios?.style?.height,
                      maxWidth: viewModel.screen?.style?.platformStyle?.ios?.style?.maxWidth,
                      maxHeight: viewModel.screen?.style?.platformStyle?.ios?.style?.maxHeight,
                      alignment: viewModel.screen?.style?.platformStyle?.ios?.style?.alignment)
            .setBackground(viewModel.screen?.style?.commonStyle?.backgroundColor)
            .setBorder(viewModel.screen?.style?.platformStyle?.ios?.style?.border)
            .opacity(viewModel.screen?.style?.commonStyle?.opacity ?? 1)
            .setMarging(viewModel.screen?.style?.platformStyle?.ios?.style?.margin)
    }
    
    @ViewBuilder fileprivate func rootView() -> some View {
        if let widget = viewModel.screen {
            let containerType = widget.style?.platformStyle?.ios?.style?.containerType ?? widget.type ?? "scroll"
            switch containerType {
            case "hstack":
                HStack {
                    content(widgets: widget.views ?? widget.children ?? [Screen]())
                }
            case "vstack", "container":
                VStack {
                    content(widgets:widget.views ?? widget.children ?? [Screen]())
                }
            case "zstack":
                ZStack {
                    content(widgets:widget.views ?? widget.children ?? [Screen]())
                }
            case "scroll":
                ScrollView {
                    VStack {
                        content(widgets: widget.views ?? widget.children ?? [Screen]())
                    }
                }
            default:
                content(widget: widget)
            }
        } else {
            ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    @ViewBuilder fileprivate func content(widgets: [Screen]) -> some View {
        ForEach(0..<widgets.count) { idx in
            let widget = widgets[idx]
            content(widget: widget)
        }
    }
    
    @ViewBuilder fileprivate func content(widget: Screen) -> some View {
        switch widget.type {
        case "image":
            ImageView(screen: widget)
        case "text":
            TextView(screen: widget)
        case "spacer":
            Spacer()
        case "button":
            Button {
                action(screen: widget)
            } label: {
                TextView(screen: widget, isDisabled: !onActive())
            }.onAppear {
                globalViewModel.userInputs[widget.variable?.key ?? ""] = widget.variable?.value
            }
            .disabled(!onActive())
        case "textfield":
            TextFieldView(screen: widget, binding: Binding(
                get: {
                    return (globalViewModel.userInputs[widget.variable?.key ?? ""] ?? "") as! String
                },
                set: { newValue in
                    return globalViewModel.userInputs[widget.variable?.key ?? ""] = newValue
                }))
        case "toggle":
            ToggleView(screen: widget)
        case "rating":
            RatingView(rating: Binding(
                get: {
                    return globalViewModel.userInputs[widget.variable!.key!] as? Int ?? Int(widget.data?.value ?? "0") ?? 0
                },
                set: { newValue in
                    return globalViewModel.userInputs[widget.variable!.key!] = newValue
                }))
        case "checkbox":
            CheckBoxView(screen: widget, checked: Binding(
                get: {
                    return (globalViewModel.userInputs[widget.variable!.key!] as? String == widget.variable?.value)
                },
                set: { newValue in
                    if (globalViewModel.userInputs[widget.variable!.key!] as? String == widget.variable?.value) {
                        globalViewModel.userInputs[widget.variable!.key!] = nil
                    } else {
                        return globalViewModel.userInputs[widget.variable!.key!] = widget.variable?.value
                    }
                }))
        case "textarea":
            TextEditorView(screen: widget, binding: Binding(
                get: {
                    return (globalViewModel.userInputs[widget.variable!.key!] ?? "") as! String
                },
                set: { newValue in
                    return globalViewModel.userInputs[widget.variable!.key!] = newValue
                }))
        case "list":
            ListView(screen: widget)
        case "accordion":
            DisclosureGroupView(screen: widget, binding: Binding(
                get: {
                    return (globalViewModel.userInputs[widget.variable!.key!] ?? "") as! String
                },
                set: { newValue in
                    return globalViewModel.userInputs[widget.variable!.key!] = newValue
                }))
        case "container":
            ContentView(screen: widget)
        case "time":
            TimePicker(screen: widget, binding: Binding(
                get: {
                    return (globalViewModel.userInputs[widget.variable!.key!] ?? "") as? Date
                },
                set: { newValue in
                    return globalViewModel.userInputs[widget.variable!.key!] = newValue
                }))
        case "radio":
            RadioView(screen: widget, checked: Binding(
                get: {
                    return (globalViewModel.userInputs[widget.variable!.key!] ?? "") as? String == widget.variable?.value
                },
                set: { newValue in
                    return globalViewModel.userInputs[widget.variable!.key!] = widget.variable?.value
                }))
        case "dropdown":
            DropDownView(screen: widget, selectedItem: Binding(
                get: {
                    let key = globalViewModel.userInputs[widget.variable!.key!] as? String
                    return widget.data?.dropDownValues?.first{$0.value == key} ?? widget.data?.dropDownValues?.first
                },
                set: { newValue in
                    return globalViewModel.userInputs[widget.variable!.key!] = newValue?.value
                }))
        default:
            EmptyView()
        }
    }
    
    func onActive() -> Bool {
        let keys = globalViewModel.userInputs.keys.map { key in
            key.split(separator: ".").last?.description
        }
        var result = [Bool]()
        GlobalData.shared.variables.filter{$0.required ?? false}.filter{$0.name != nil}.map{$0.name!}.forEach{
            result.append(keys.contains($0))
        }
        return result.first{!$0} ?? true
    }
    
    func action(screen: Screen?) {
        var url: String?
        switch screen?.action?.actionType {
        case "goBack":
            viewModel.goBack()
            presentationMode.wrappedValue.dismiss()
            break
        case "link":
            url = screen?.action?.actionData?.url
            break
        case "phone":
            if let phone = screen?.action?.actionData?.phoneNum {
                let call: String = "telprompt://\(phone)"
                url = call.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            }
        case "sms":
            if let phone = screen?.action?.actionData?.phoneNum {
                let sms: String = "sms:\(phone)&body=\(screen?.action?.actionData?.value ?? "")"
                url = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            }
        case "email":
            if let email = screen?.action?.actionData?.email {
                let subject = screen?.action?.actionData?.value ?? ""
                url = "mailto:\(email)?subject=\(subject)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            }
        case "alert":
            globalViewModel.userInputs[screen?.variable?.key ?? ""] = screen?.variable?.value
            presentLikeAlert.toggle()
        case "kustomer":
            Kustomer.show()
        default:
            globalViewModel.userInputs[screen?.variable?.key ?? ""] = screen?.variable?.value
            present.toggle()
        }
        if let sUrl = url, let _url = URL(string: sUrl) {
            UIApplication.shared.open(_url, options: [:], completionHandler: nil)
        }
    }
}
