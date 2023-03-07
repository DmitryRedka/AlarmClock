//
//  AddAlarmViewController.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 05.03.2023.
//

import UIKit

protocol SaveAlarmInfoDelegate:AnyObject{
    func saveAlarmInfo(alarmData:AlarmInfo, index: Int)
}

class AddAlarmViewController: UIViewController {
    
    var contentItems: [ContentItem] {
        [
            .days(alarm.repeatDay),
            .label(alarm.note),
            .sounds("Нет"),
            .snooze(false)
        ]
    }
    
    var alarm = AlarmInfo(){
        didSet{
            datePicker.date = alarm.date
            tableView.reloadData()
        }
    }
    
    //MARK: - UI
    let datePicker:UIDatePicker = {
        let myPicker = UIDatePicker()
        myPicker.datePickerMode = .time
        myPicker.locale = Locale(identifier: "NL")
        myPicker.preferredDatePickerStyle = .wheels
        return myPicker
    }()
    
    let tableView:UITableView = {
        let myTable = UITableView()
        myTable.layer.cornerRadius = 10
        myTable.isScrollEnabled = false
        myTable.register(AddAlarmTableViewCell.self, forCellReuseIdentifier: AddAlarmTableViewCell.identifier)
        myTable.register(AddAlarmButtonTableViewCell.self, forCellReuseIdentifier: AddAlarmButtonTableViewCell.identifier)
        
        return myTable
    }()
    
    var tempIndexRow:Int = 0
    
     weak var saveAlarmDataDelegate: SaveAlarmInfoDelegate?
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        setupUI()
        setupNavigation()
    }
    
    
    //MARK: - setupUI
    func setupUI(){
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(datePicker)
        self.view.addSubview(tableView)

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            datePicker.heightAnchor.constraint(equalToConstant: 256),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 256),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 200),
        ])

    }
    
    //MARK: - setup Navigation
    func setupNavigation(){
        navigationItem.title = "Добавление"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButton))
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem?.tintColor = .orange
    }
    
    @objc func cancelButton(){
        self.dismiss(animated: true)
    }
    
    @objc func saveButton(){
        alarm.date = datePicker.date
        saveAlarmDataDelegate?.saveAlarmInfo(alarmData: alarm, index: tempIndexRow)
        self.dismiss(animated: true)
    }

    
}

//MARK: - UITableView
extension AddAlarmViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        let item = contentItems[indexPath.row]
     
        switch item {
        case .days:
            let repeatVC = RepeatAlarmViewController()
            repeatVC.repeatDelegate = self
            repeatVC.selectDays = alarm.selectDays
            self.navigationController?.pushViewController(repeatVC, animated: true)
            
        case .label:
            let labelVC = AlarmLabelViewController()
            labelVC.textField.text = alarm.note
            labelVC.labelDelegate = self
            self.navigationController?.pushViewController(labelVC, animated: true)

        default:
            break
        }
       
    }
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


//MARK: - protocol delegate
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
            case .label: return "Название"
            case .sounds: return "Мелодия"
            case .snooze: return "Повторение сигнала"
            case .days: return "Повтор"
            }
        }
    }
    
    
    
}
