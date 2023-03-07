//
//  WakeUpTableViewCell.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 05.03.2023.
//

import UIKit

final class WakeUpTableViewCell: UITableViewCell {
    
    //MARK: - UI
    let settingButton:UIButton = {
        let settingButton = UIButton(frame: .zero)
        settingButton.setTitle("НАСТРОИТЬ", for: .normal)
        settingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        settingButton.setTitleColor(.orange, for: .normal)
        settingButton.backgroundColor = Resources.Colors.darkGrey
        settingButton.layer.cornerRadius = 15
        settingButton.layer.masksToBounds = true
        return settingButton
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - setupUI
    func setupUI(){
        textLabel?.textColor = .lightGray
        self.addSubview(settingButton)
        //TODO: Добавить констрейнты
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            settingButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            settingButton.widthAnchor.constraint(equalToConstant: 120),
            settingButton.heightAnchor.constraint(equalToConstant: 30),
            settingButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
         
    }
    
    
}

