//
//  ViewController.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 04.03.2023.
//

import UIKit

class AlarmClockController: BaseController  {

    var alarmStore = AlarmStore(){
        didSet{
            alarmTableView.reloadData()
        }
    }
    //MARK: - UI
    let alarmTableView: UITableView = {
        let myTable = UITableView(frame: .zero, style: .grouped)
        myTable.separatorStyle = .singleLine
        myTable.register(WakeUpTableViewCell.self, forCellReuseIdentifier: "wakeup")
        myTable.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: "other")
        return myTable
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        alarmTableView.dataSource = self
        alarmTableView.delegate = self
        setupNavigation()
        setViews()
        setLayouts()
    }
    override func navBarAddButtonHandler() {
        alarmStore.isEdit = false
        let vc = AddAlarmViewController()
        vc.saveAlarmDataDelegate = self
        let addAlarmNC = UINavigationController(rootViewController: vc)
        present(addAlarmNC, animated: true, completion: nil)
        
    }
    
    //MARK: - setViews
    func setViews(){
        alarmTableView.backgroundColor = .black
        self.view.addSubview(alarmTableView)
    }
    
    //MARK: - setLayouts
    func setLayouts(){
        alarmTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alarmTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            alarmTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            alarmTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            alarmTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    func setupNavigation(){
        navigationItem.title = "Будильник"
        navigationItem.leftBarButtonItem = editButtonItem
        addNavBarButton(at: .left, title: "Править", image: nil)
        addNavBarButton(at: .right, title: nil, image: Resources.Images.NavBar.rightButton)

        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .orange
        editButtonItem.tintColor = .orange
    }
    
}
//MARK: - tableView
extension AlarmClockController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = AlarmSection.allCases[section]
        switch item{
        case .wakeup:
            return 1
        case .other:
            return alarmStore.alarms.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = AlarmSection.allCases[indexPath.section]
        switch item{
        case .wakeup:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "wakeup", for: indexPath) as? WakeUpTableViewCell else {return UITableViewCell()}
            cell.textLabel?.text = "Нет будильника"
            return cell
        case .other:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "other", for: indexPath) as? AlarmOtherTableViewCell else {return UITableViewCell()}
            let alarm = alarmStore.alarms[indexPath.row]
            
            cell.textLabel?.text = alarm.date.toString(format: "HH:mm")
            cell.detailTextLabel?.text = alarm.noteLabel
            cell.lightSwitch.isOn = alarm.isOn
            cell.textLabel?.textColor = alarm.isOn ? .white : .darkGray
            cell.detailTextLabel?.textColor = alarm.isOn ? .white : .darkGray
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
        return AlarmSection.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item = AlarmSection.allCases[section]
        switch item{
        case .wakeup:
            return "Cон | Пробуждение"
        case .other:
            return "Другие"
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
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 { return true }
        return false
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            alarmStore.remove(indexPath.row)
        }
    }
}

extension AlarmClockController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = AlarmSection.allCases[indexPath.section]
        switch item{
        case .other:
            alarmStore.isEdit = true
            let vc = AddAlarmViewController()
            vc.saveAlarmDataDelegate = self
            let alarm = alarmStore.alarms[indexPath.row]
            vc.alarm = alarm
            vc.tempIndexRow = indexPath.row
            let addAlarmNC = UINavigationController(rootViewController: vc)
            present(addAlarmNC, animated: true, completion: nil)
          
            tableView.deselectRow(at: indexPath, animated: false)
            
        default: ()
        }
    }
}

//MARK: - saveAlarm
extension AlarmClockController:SaveAlarmInfoDelegate{
    func saveAlarmInfo(alarmData: AlarmInfo, index: Int) {
        if alarmStore.isEdit == false{
            alarmStore.append(alarmData)
        }else{
            alarmStore.edit(alarmData, index)
        }
    }
}


extension AlarmClockController{
    enum AlarmSection:Int, CaseIterable{
        case wakeup = 0, other
    }
}

