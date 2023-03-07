//
//  TabberViewController.swift
//  my_ios_clock
//
//  Created by 危末狂龍 on 2022/10/19.
//

import UIKit


class TabberViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定各個導覽分頁
        setupTabBarController()
    }
    
    func setupTabBarController(){
        //這邊讓四個分頁連接到各自的view，設定個分頁名稱＆圖示
        let world_clock_page = UINavigationController(rootViewController: world_clock_controller())
        world_clock_page.tabBarItem.image = UIImage(systemName: "network")
        world_clock_page.title = "世界時鐘"
        
        let alarm_clock_page = UINavigationController(rootViewController: AlarmViewController())
        alarm_clock_page.tabBarItem.image = UIImage(systemName: "alarm.fill")
        alarm_clock_page.title = "鬧鐘"
            
        let stop_watch_page = UINavigationController( rootViewController:stop_watch_controller())
        stop_watch_page.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        stop_watch_page.title = "碼錶"
        
        let timer_page = UINavigationController( rootViewController:timer_controller())
        timer_page.tabBarItem.image = UIImage(systemName: "timer")
        timer_page.title = "計時器"
        
        
        self.tabBar.barTintColor = .clear
        self.tabBar.tintColor = .orange
        //加入ViewControllers
        setViewControllers([world_clock_page, alarm_clock_page, stop_watch_page, timer_page], animated: false)
        
        //設定大標題 (考慮拉到分頁內)
        alarm_clock_page.navigationBar.prefersLargeTitles = true
        alarm_clock_page.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         .font: UIFont.boldSystemFont(ofSize: 34)]
    }
    
}
