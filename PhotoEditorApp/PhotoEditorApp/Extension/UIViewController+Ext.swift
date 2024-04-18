//
//  UIViewController+Ext.swift
//  PhotoEditorApp
//
//  Created by Avi Kheni on 17/04/24.
//

import Foundation
import UIKit

extension UIViewController {
    func permissionForAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Open", style: .default) { _ in
                self.openSettings()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { success in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    
    func  addTextAlert(title:String? = nil,
                            subtitle:String? = nil,
                            actionTitle:String? = "Add",
                            cancelTitle:String? = "Cancel",
                            inputPlaceholder:String? = nil,
                            inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                            cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                            actionHandler: ((_ text: String?) -> Void)? = nil) {
           
           let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
           alert.addTextField { (textField:UITextField) in
               textField.placeholder = inputPlaceholder
               textField.keyboardType = inputKeyboardType
           }
           alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
               guard let textField =  alert.textFields?.first else {
                   actionHandler?(nil)
                   return
               }
               actionHandler?(textField.text)
           }))
           alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
           
           self.present(alert, animated: true, completion: nil)
       }
}
