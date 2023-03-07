//
//  BaseController.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 04.03.2023.
//

import UIKit

enum NavBarPosition {
    case left
    case right
}
 
class BaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @objc func navBarEditButtonHandler () {
        print ("Left nav button touch")
    }
    
    @objc func navBarAddButtonHandler () {
        print ("Right nav button touch")
    }
    
}


extension BaseController {

    func addNavBarButton(at position: NavBarPosition, title: String?, image: UIImage?) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = Resources.Colors.orange
        button.setTitleColor(Resources.Colors.orange, for: .normal)
        
    
        switch position{
        case .left:
            button.addTarget(self, action: #selector(navBarEditButtonHandler), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        case .right:
            button.addTarget(self, action: #selector(navBarAddButtonHandler), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        }
     }         
}

