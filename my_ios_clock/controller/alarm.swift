//
//  alarm.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/20.
//

import UIKit

    class AlarmViewController: UIViewController{
        //建立鬧鐘存儲，用來存放每次表格的資料變化
        var alarmStore = AlarmStore(){
            didSet{
                alarmTableView.reloadData()
            }
        }
        
        //MARK: - UI
        //建立鬧鐘列表視窗
        let alarmTableView:UITableView = {
            let myTable = UITableView(frame: .zero, style: .grouped)
            myTable.separatorStyle = .singleLine
            myTable.register(WakeUpTableViewCell.self, forCellReuseIdentifier: "wakeup")
            myTable.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: "other")
            return myTable
        }()
        
        //MARK: - lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            alarmTableView.dataSource = self
            alarmTableView.delegate = self
            setupNavigation()
            setViews()
            setLayouts()
        }
        
        // 畫面從其他tab頁面回來預設皆為不可編輯狀態
        override func viewWillDisappear(_ animated: Bool) {
            self.isEditing = false
            editButtonItem.title = "編輯"
        }

        //MARK: - setViews
        func setViews(){
            self.view.addSubview(alarmTableView)
        }
        
        //MARK: - setLayouts
        func setLayouts(){
            alarmTableView.frame = view.bounds
        }
        
        //MARK: - setup Navegation
        func setupNavigation(){
            navigationItem.title = "鬧鐘"
            navigationItem.leftBarButtonItem = editButtonItem
            navigationItem.leftBarButtonItem?.action = #selector(editAlarmList)
            editButtonItem.title = "編輯"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm))
            
            //設置顏色
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
            navigationItem.rightBarButtonItem?.tintColor = .orange
            editButtonItem.tintColor = .orange
        }
        

        
        //editButton
        override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)
            alarmTableView.setEditing(editing, animated: true)
        }
        //每次依據isEditing的布林值，決定編輯鍵要顯示的字樣
        @objc func editAlarmList(_ sender: UIBarButtonItem) {
            alarmTableView.setEditing(!alarmTableView.isEditing, animated: false)
            editButtonItem.title = alarmTableView.isEditing ? "完成" : "編輯"
            alarmTableView.reloadData()
        }
        //每次新增鬧鐘提醒時，依據vc做為儲存格
        @objc func addAlarm(){
            alarmStore.isEdit = false
            let vc = AddAlarmViewController()
            vc.saveAlarmDataDelegate = self
            let addAlarmNC = UINavigationController(rootViewController: vc)
            present(addAlarmNC, animated: true, completion: nil)
        }
    }

    //MARK: - tableView
    extension AlarmViewController:UITableViewDataSource{
        //AlarmSection，tableView分組設定（wakeup ＆ other）
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let item = AlarmSection.allCases[section]
            switch item{
            case .wakeup:
                return 1
            case .other:
                return alarmStore.alarms.count
            }
        }
        //設定Section屬性
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let item = AlarmSection.allCases[indexPath.section]
            switch item{
            case .wakeup:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "wakeup", for: indexPath) as? WakeUpTableViewCell else {return UITableViewCell()}
                cell.textLabel?.text = "沒有鬧鐘"
                return cell
            case .other:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "other", for: indexPath) as? AlarmOtherTableViewCell else {return UITableViewCell()}
                let alarm = alarmStore.alarms[indexPath.row]
                
                cell.textLabel?.text = alarm.date.toString(format: "HH:mm")
                cell.detailTextLabel?.text = alarm.noteLabel
                cell.lightSwitch.isHidden = alarmTableView.isEditing ? true : false
                cell.lightSwitch.isOn = alarm.isOn
                
                cell.callBackSwitchState = {isOn in
                    self.alarmStore.isSwitch(indexPath.row, isOn)
                }
                return cell
            }
        }
        


        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            100
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let item = AlarmSection.allCases[section]
            switch item{
            case .wakeup:
                return "睡眠 | 起床鬧鐘"
            case .other:
                return "其他"
            }
        }
        
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            guard let header = view as? UITableViewHeaderFooterView else { return }
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            header.textLabel?.textColor = .white
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
        
        //是否能使用edit編輯
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            if indexPath.section == 1{ return true}
            return false
        }
        
        //刪除cell
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                alarmStore.remove(indexPath.row)
            }
        }
    }

    extension AlarmViewController:UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.section == 1{
                alarmStore.isEdit = true
                let vc = AddAlarmViewController()
                vc.saveAlarmDataDelegate = self
                let alarm = alarmStore.alarms[indexPath.row]
                vc.alarm = alarm
                vc.tempIndexRow = indexPath.row
                let addAlarmNC = UINavigationController(rootViewController: vc)
                present(addAlarmNC, animated: true, completion: nil)
                //取消select的狀態
                tableView.deselectRow(at: indexPath, animated: false)
            }
        }
    }

    //MARK: - saveAlarm
    extension AlarmViewController:SaveAlarmInfoDelegate{
        func saveAlarmInfo(alarmData: AlarmInfo, index: Int) {
            if alarmStore.isEdit == false{
                alarmStore.append(alarmData)
            }else{
                alarmStore.edit(alarmData, index)
            }
        }
    }
    
    protocol SaveAlarmInfoDelegate:AnyObject{
        func saveAlarmInfo(alarmData:AlarmInfo, index: Int)
    }

    extension AlarmViewController{
        enum AlarmSection:Int, CaseIterable{
            case wakeup = 0, other
        }
    }

extension AlarmViewController{
    //創建鬧鐘通知
    func notificationFromAlarm(alarm: AlarmInfo){
        let content = UNMutableNotificationContent()
        content.body = "\(alarm.note)"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("123.wav"))
    }
}

