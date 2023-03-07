//
//  AlarmLabelViewController.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 07.03.2023.
//

import UIKit

class AlarmLabelViewController: UIViewController,UITextFieldDelegate {

    
    //MARK: - UI
    let textField:UITextField = {
       let myTextField = UITextField()
        myTextField.returnKeyType = .done
        myTextField.clearButtonMode = .whileEditing
        myTextField.borderStyle = .roundedRect
        return myTextField
    }()
    
    weak var labelDelegate:UpdateAlarmLabelDelegate?
    
    override func viewWillDisappear(_ animated: Bool) {
            
            if let text = textField.text {
                if text == "" {
                    labelDelegate?.updateAlarmLabel(alarmLabelText: "Будильник")
                }else {
                    labelDelegate?.updateAlarmLabel(alarmLabelText: text)
                }
            }
        }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        textField.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        textField.becomeFirstResponder()
    }
            
    //MARK: - SetupUI
    func setupUI(){
        
        navigationController?.navigationBar.tintColor = .orange
        
        self.title = "Будильник"
        view.addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            textField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -120),
            textField.heightAnchor.constraint(equalToConstant: 45),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.popViewController(animated: true)
        return true
    }
}



