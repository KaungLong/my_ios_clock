//
//  addAlarmController.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/26.
//

import UIKit

class AddAlarmViewController: UIViewController {
        
    var contentItems: [ContentItem] {
        [
            .days(alarm.repeatDay),
            .label(alarm.note),
            .sounds("無"),
            .snooze(false)
        ]
    }
    
    var alarm = AlarmInfo(){
        didSet{
            datePicker.date = alarm.date
            tableView.reloadData()
        }
    }
    
    let datePicker:UIDatePicker = {
        let myPicker = UIDatePicker()
        myPicker.datePickerMode = .time
        myPicker.locale = Locale(identifier: "NL")
        myPicker.preferredDatePickerStyle = .wheels
        myPicker.translatesAutoresizingMaskIntoConstraints = false
        return myPicker
    }()
    
    let tableView:UITableView = {
        let myTable = UITableView()
        myTable.layer.cornerRadius = 10
        myTable.isScrollEnabled = false
        myTable.register(AddAlarmTableViewCell.self, forCellReuseIdentifier: AddAlarmTableViewCell.identifier)
        myTable.register(AddAlarmButtonTableViewCell.self, forCellReuseIdentifier: AddAlarmButtonTableViewCell.identifier)
        myTable.translatesAutoresizingMaskIntoConstraints = false
        myTable.rowHeight = 50
        return myTable
    }()
    
    var tempIndexRow:Int = 0
    
    weak var saveAlarmDataDelegate: SaveAlarmInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        setupUI()
        setupNavigation()
    }
    
    func setupUI(){

        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(datePicker)
        self.view.addSubview(tableView)
        
        datePicker.topAnchor.constraint(equalTo: view.topAnchor,constant: 48).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 18).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: datePicker.bottomAnchor,constant: 42).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200 ).isActive = true
        
    }
    
    func setupNavigation(){
        navigationItem.title = "加入鬧鐘"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:#selector(cancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(saveButton))
        //設定各物件顏色
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem?.tintColor = .orange
    }
    
    @objc func cancelButton(){
        self.dismiss(animated: true)
    }
    
    @objc func saveButton(){
        alarm.date = datePicker.date
        if alarm.selectDays.isEmpty{
            UserNotification.addNotificationRequest(alarm: alarm)
            print("no weekdays")
        }else {
            for dayInts in alarm.selectDays{
                var dayInt:Int{
                    switch dayInts{
                        case .Sun: return 1
                        case .Mon: return 2
                        case .Tue: return 3
                        case .Wed: return 4
                        case .Thu: return 5
                        case .Fri: return 6
                        case .Sat: return 7
                    }
                }
                UserNotification.addNotificationRequest(alarm: alarm,days: dayInt)
            }
        }
        
        saveAlarmDataDelegate?.saveAlarmInfo(alarmData: alarm, index: tempIndexRow)
        self.dismiss(animated: true)
    }
}




extension AddAlarmViewController:UITableViewDataSource, UITableViewDelegate{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentItems.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("測試row \(contentItems[indexPath.row])")
        
        let item = contentItems[indexPath.row]
        let title = item.title
        switch item {
        case .snooze(let bool):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmButtonTableViewCell.identifier, for: indexPath) as? AddAlarmButtonTableViewCell else{ return UITableViewCell() }
            cell.titleLabel.text = title
            cell.mySwitch.isOn = bool
            return cell
        case .label(let string), .days(let string), .sounds(let string):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmTableViewCell.identifier, for: indexPath) as? AddAlarmTableViewCell else{ return UITableViewCell() }
            cell.titleLabel.text = title
            cell.contentLabel.text = string
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("測試row \(contentItems[indexPath.row])")
        let item = contentItems[indexPath.row]
        switch item{
        case .days:
            let repeatVC = RepeatAlarmViewController()
            repeatVC.repeatDelegate = self
            repeatVC.selectDays = alarm.selectDays
            self.navigationController?.pushViewController(repeatVC, animated: true)
            print("測試row \(contentItems[indexPath.row])")
        case .label:
            print("測試row \(contentItems[indexPath.row])")
          
            let labelVC = AlarmLabelViewController()
            labelVC.textField.text = alarm.note
            labelVC.labelDelegate = self
            self.navigationController?.pushViewController(labelVC, animated: true)
            
        default:
            break
        }
    }
    //tableView高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension AddAlarmViewController:UpdateAlarmLabelDelegate{
    func updateAlarmLabel(alarmLabelText: String) {
        alarm.note = alarmLabelText
    }
}

extension AddAlarmViewController:UpdateRepeatLabelDelegate{
    func updateRepeatLabel(selectedDay: Set<Day>) {
        alarm.selectDays = selectedDay
    }
}

protocol UpdateAlarmLabelDelegate:AnyObject{
    func updateAlarmLabel(alarmLabelText: String)
}

protocol UpdateRepeatLabelDelegate:AnyObject{
    func updateRepeatLabel(selectedDay:Set<Day>)
}

extension AddAlarmViewController {
    
    enum ContentItem {
        case days(String), label(String), sounds(String), snooze(Bool)
        
        var title: String {
            switch self {
            case .label: return "標籤"
            case .sounds: return "提示聲"
            case .snooze: return "稍後提醒"
            case .days: return "重複"
            }
        }
    }
    
    
    
}

