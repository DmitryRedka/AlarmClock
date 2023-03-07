//
//  AddAlarmButtonTableViewCell.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 05.03.2023.
//

import UIKit

final class AddAlarmButtonTableViewCell: UITableViewCell {

    static let identifier = "addAlarmButtonTableViewCell"
    
    let mySwitch = UISwitch()

    let titleLabel:UILabel = {
       let myLabel = UILabel()
        
        return myLabel
    }()
    
    //MARK: - init
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 14)
        ])
    }
        @objc func switchChanged(_ sender : UISwitch!){
           print("table row switch Changed \(sender.tag)")
            print("The switch is \(sender.isOn ? "ON" : "OFF")")
        }
}

