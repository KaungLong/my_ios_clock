//
//  AddAlarmButtonTableViewCell.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/26.
//

import UIKit

//為了要製作UISwitch多新建了一個cell
class AddAlarmButtonTableViewCell: UITableViewCell {
    static let identifier = "addAlarmButtonTableViewCell"
    
    let mySwitch = UISwitch()

    let titleLabel:UILabel = {
       let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryView = mySwitch
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 14).isActive = true
        
    }
}
