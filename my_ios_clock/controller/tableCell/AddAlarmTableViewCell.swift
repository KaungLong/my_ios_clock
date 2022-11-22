//
//  AddAlarmTableViewCell.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/26.
//

import UIKit

class AddAlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AddAlarmTableViewCell"
    
    let titleLabel:UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    let contentLabel:UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .lightGray
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    let detailImageView: UIImageView = {
            // 設定這個 imageView 的圖案為 "chevron.right"
            let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
            // 設定這個 imageView 的顏色為灰色
            imageView.tintColor = .lightGray
            return imageView
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //顯示 ">" 符號
        self.accessoryView = detailImageView
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor ).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 14).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -200).isActive = true
        
        contentLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor ).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -50).isActive = true
 
    }
}
