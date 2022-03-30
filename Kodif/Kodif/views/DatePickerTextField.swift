//
//  DatePickerTextField.swift
//  Codif
//
//  Created by Izzat on 09.11.2021.
//

import SwiftUI
import UIKit

final class DatePickerTextField: UITextField {
    @Binding var date: Date?
    private let datePicker = UIDatePicker()
    
    init(date: Binding<Date?>, frame: CGRect) {
        self._date = date
        super.init(frame: frame)
        inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerDidSelect(_:)), for: .valueChanged)
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(dismissTextField))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        inputAccessoryView = toolBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func datePickerDidSelect(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    @objc private func dismissTextField() {
        resignFirstResponder()
    }
    
}
