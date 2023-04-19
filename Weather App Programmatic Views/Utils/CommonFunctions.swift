//
//  CommonFunctions.swift
//  Weather App
//
//  Created by Kuda Zata on 29/11/2022.
//

import Foundation
import UIKit

/// This function creates a two button UIAlert from any view controller within the app. This alert shows two buttons: "Retry" and "Cancel"
/// - Parameters:
///   - title: The title of the alert (eg "Network Error")
///   - message: The text body of the alert
///   - vc: the ViewController from which the alert will be displayed
///   - completion: A completion block to be executed when a user clicks on the Retry button
func showRetryAlert(title: String!, message: String!, vc: UIViewController, completion: @escaping (() -> Void)) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
        completion()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}


/// This function creates a UIAlert with a textfield from any view controller within the app.
/// This alert shows two buttons: "Submit" and "Cancel"
/// - Parameters:
///   - title: The title of the alert (eg "Enter name")
///   - message: The text body of the alert
///   - vc: the ViewController from which the alert will be displayed
///   - completion: A completion block to be executed when a user clicks on the Retry button returning the string typed into the textfield
func showAlertWithTextField(title: String, message: String, placeholder: String, vc: UIViewController, completion: @escaping ((String) -> Void)) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    
    alert.addTextField { textfield in
        textfield.placeholder = placeholder
    }
    
    alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (UIAlertAction) in
        
        if let textfields = alert.textFields, let textfield = textfields.first, let text = textfield.text {
            completion(text)
        }
        
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
    }))
    
    vc.present(alert, animated: true, completion: nil)
    
}

/// This function creates a UIAlert from any view controller within the app.
/// - Parameters:
///   - title: The title of the alert (eg "Enter name")
///   - message: The text body of the alert
///   - vc: the ViewController from which the alert will be displayed
///   - completion: A completion block to be executed when a user clicks OK button
func showGeneralAlert(title: String, message: String, vc: UIViewController, buttonTitle: String? = "OK", completion: (() -> Void)? = {}) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
        completion?()
    }))
    vc.present(alert, animated: true, completion: nil)
}
