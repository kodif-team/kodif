//
//  DatePickerInputView.swift
//  Codif
//
//  Created by Izzat on 09.11.2021.
//

import SwiftUI

struct DatePickerInputView: UIViewRepresentable {
    @Binding var date: Date?
    let placeholder: String
    
    init(date: Binding<Date?>, placeholder: String) {
        self._date = date
        self.placeholder = placeholder
    }
    
    func updateUIView(_ uiView: DatePickerTextField, context: Context) {
        if let date = date {
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "hh:mm a"
            uiView.text = formatter3.string(from: date)
        }
    }
    
    func makeUIView(context: Context) -> DatePickerTextField {
        let dptf = DatePickerTextField(date: $date, frame: .zero)
        dptf.placeholder = placeholder
        if let date = date {
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "hh:mm a"
            dptf.text = formatter3.string(from: date)
        }
        
        return dptf
    }
    
}
