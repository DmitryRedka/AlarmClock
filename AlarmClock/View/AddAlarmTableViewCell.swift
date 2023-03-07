//
//  AddAlarmTableViewCell.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 05.03.2023.
//

import UIKit

final class AddAlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AddAlarmTableViewCell"
    
    //MARK: - setupUI
    let titleLabel:UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        return myLabel
    }()
    
    let contentLabel:UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .lightGray
        return myLabel
    }()

    let detailImageView: UIImageView = {

            let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
          
            imageView.tintColor = .lightGray
            return imageView
        }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     
        self.accessoryView = detailImageView
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 14)
        ])
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            contentLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])
    }
    
    
    
}

