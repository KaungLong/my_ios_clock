//
//  WakeUpTableViewCell.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/25.
//

import UIKit

class WakeUpTableViewCell: UITableViewCell {
    let settingButton:UIButton = {
        let settingButton = UIButton(frame: .zero)
        settingButton.setTitle("更改", for: .normal)
        settingButton.setTitleColor(.orange, for: .normal)
        settingButton.backgroundColor = .systemGray6
        settingButton.layer.cornerRadius = 15
        settingButton.layer.masksToBounds = true
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        return settingButton
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        //暫時無法點擊
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        textLabel?.textColor = .lightGray
        self.addSubview(settingButton)

        settingButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        settingButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        settingButton.widthAnchor.constraint(equalToConstant: 80 ).isActive = true
    }
    
}
