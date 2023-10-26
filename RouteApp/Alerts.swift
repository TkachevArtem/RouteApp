//
//  Alert.swift
//  RouteApp
//
//  Created by Artem Tkachev on 24.10.23.
//

import UIKit

extension UIViewController {
    
    func alertAddAdress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let textFieldText = alertController.textFields?.first
            guard let text = textFieldText?.text else { return }
            completionHandler(text)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default)
        
        alertController.addAction(alertOkAction)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true)
    }
    
    func allert(title: String, message: String ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOkAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(alertOkAction)
        
        present(alertController, animated: true)
    }
    
}
