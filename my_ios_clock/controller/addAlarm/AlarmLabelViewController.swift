//
//  AlarmLabelViewController.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/11/1.
//

import UIKit

class AlarmLabelViewController: UIViewController,UITextFieldDelegate {
    
    let textField:UITextField = {
       let myTextField = UITextField()
        myTextField.returnKeyType = .done
        myTextField.clearButtonMode = .whileEditing
        myTextField.borderStyle = .roundedRect
        myTextField.translatesAutoresizingMaskIntoConstraints   = false
        return myTextField
    }()
    
    weak var labelDelegate:UpdateAlarmLabelDelegate?
    
    override func viewWillDisappear(_ animated: Bool) {
            
            if let text = textField.text {
                if text == "" { // 若輸入框內為空白，回傳 Alarm
                    labelDelegate?.updateAlarmLabel(alarmLabelText: "鬧鐘")
                }else { // 若輸入框內不為空白，回傳「輸入框內的文字」
                    labelDelegate?.updateAlarmLabel(alarmLabelText: text)
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        textField.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //讓keyboard直接出現在畫面上
        textField.becomeFirstResponder()
    }
    
    func setupUI(){
        
        navigationController?.navigationBar.tintColor = .orange
        
        self.title = "Label"
        view.addSubview(textField)
        textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -120).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
       }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.popViewController(animated: true)
        return true
    }
}
