//
//  timer.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/20.
//
import UIKit


class timer_controller: UIViewController {
    private let ex_words: UILabel = {
        let label = UILabel()
        label.text = "待完成"
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ex_words)
        
        setupAutoLayout()
        // Do any additional setup after loading the view.
    }
    
    func setupAutoLayout() {
        ex_words.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ex_words.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
