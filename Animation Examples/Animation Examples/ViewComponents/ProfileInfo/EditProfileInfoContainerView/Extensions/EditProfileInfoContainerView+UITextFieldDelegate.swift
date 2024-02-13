//
//  EditProfileInfoContainerView+UITextFieldDelegate.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


extension EditProfileInfoContainerView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = getParentView(for: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let parentView = getParentView(for: textField) {
            if let nextField = getNextParentView(for: parentView) {
                nextField.becomeFirstResponder()
                activeField = nextField
            } else {
                parentView.resignFirstResponder()
            }
        }
        
        return true
    }
    
    private func getParentView(for textField: UITextField) -> EditProfileTextField? {
        for parentView in uiConfig.textFields {
            if parentView.textField === textField {
                return parentView
            }
        }
        
        return nil
    }
    
    private func getNextParentView(for parentView: EditProfileTextField) -> EditProfileTextField? {
        for (i, pv) in uiConfig.textFields.enumerated() {
            if pv === parentView, i+1 < uiConfig.textFields.count {
                return uiConfig.textFields[i+1]
            }
        }
        
        return nil
    }
}

