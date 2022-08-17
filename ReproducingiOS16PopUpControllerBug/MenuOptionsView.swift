//
//  MenuOptionsView.swift
//  Coursicle
//
//  Created by Aaron Minkov on 8/31/21.
//  Copyright © 2021 Coursicle. All rights reserved.
//

import UIKit

class MenuOptionsView : UIButton {
        
    let rowHeight : CGFloat = CGFloat(48)
    let rowWidth : CGFloat = CGFloat(deviceScreenWidth)*0.9
    let infoLabelLeftPadding : CGFloat = CGFloat(10)
    let defaultInfoLabelFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    let userRowTouchDownColor = UIColor.init(named: "#f5f5f5")
    let separatorLeftMargin: CGFloat = 45
    
    var iconView : UILabel = {
        var iconView = UILabel()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.textColor = UIColor.init(named: "#969696")
        iconView.textAlignment = NSTextAlignment.center
        //iconView.font = UIFont.fontAwesome(ofSize: 22, style: .regular)
        iconView.isUserInteractionEnabled = true
//        iconView.backgroundColor = UIColor.orange
        return iconView
    }()
    
    var infoLabel : UILabel = {
        var infoLabel = UILabel()
//        infoLabel.backgroundColor = UIColor.blue
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.textColor = UIColor.darkGray
        infoLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return infoLabel
    }()
    
    var checkmarkIconView : UILabel = {
        var checkmarkIconView = UILabel()
//        infoLabel.backgroundColor = UIColor.blue
        checkmarkIconView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkIconView.textColor = UIColor.systemBlue
        checkmarkIconView.textAlignment = NSTextAlignment.center
        //checkmarkIconView.font = UIFont.fontAwesome(ofSize: 22, style: .regular)
        //checkmarkIconView.text = String.fontAwesomeIcon(name: .check)
        return checkmarkIconView
    }()
    
    var labelHeightConstraint : NSLayoutConstraint? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        addSubview(infoLabel)
        addSubview(checkmarkIconView)
//        backgroundColor = UIColor.systemTeal
        
        layer.cornerRadius = rowHeight / 2
        
        checkmarkIconView.isHidden = true
        
        setupLayout()
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: rowHeight),
            widthAnchor.constraint(equalToConstant: rowWidth),
            iconView.widthAnchor.constraint(equalToConstant: rowHeight),
            iconView.heightAnchor.constraint(equalTo: self.heightAnchor),
            iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            infoLabel.rightAnchor.constraint(equalTo: checkmarkIconView.leftAnchor, constant: 0),
            infoLabel.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: infoLabelLeftPadding),
            checkmarkIconView.widthAnchor.constraint(equalToConstant: rowHeight),
            checkmarkIconView.heightAnchor.constraint(equalTo: self.heightAnchor),
            checkmarkIconView.rightAnchor.constraint(equalTo: rightAnchor, constant: -17)
        ])
        
        labelHeightConstraint = infoLabel.heightAnchor.constraint(equalToConstant: rowHeight)
        if let labelHeightConstraint = self.labelHeightConstraint {
            labelHeightConstraint.isActive = true
        }
        infoLabel.font = defaultInfoLabelFont

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}
