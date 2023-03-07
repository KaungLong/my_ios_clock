//
//  RepeatAlarmViewController.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/31.
//

import UIKit

class RepeatAlarmViewController: UIViewController {

    var selectDays:Set<Day> = []
    
    //MARK: - UI
    let tableView:UITableView = {
        let myTable = UITableView(frame: CGRect.zero, style: .insetGrouped)
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.tintColor = .orange
        myTable.translatesAutoresizingMaskIntoConstraints = false
        myTable.rowHeight = 50
        return myTable
    }()
    
    weak var repeatDelegate:UpdateRepeatLabelDelegate?

    //把view移除時
    override func viewWillDisappear(_ animated: Bool) {
        repeatDelegate?.updateRepeatLabel(selectedDay: selectDays)
    }

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        setupUI()
    }
    
    func setupUI(){
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.backBarButtonItem?.title = "返回"
        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor ).isActive = true
    }
    
}

extension RepeatAlarmViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Day.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("測試row \(Day.allCases[indexPath.row])")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let day = Day.allCases[indexPath.row]
        let isSelected = selectDays.contains(day)
        cell.textLabel?.text = day.dayString
        cell.accessoryType = isSelected ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = Day.allCases[indexPath.row]
        if selectDays.contains(day){
            selectDays.remove(day)
        }else{
            selectDays.insert(day)
        }
        //點選時有動畫
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


