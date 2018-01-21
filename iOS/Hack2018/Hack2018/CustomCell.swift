//
//  CustomCell.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-21.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var title = UILabel()
    var status = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        title.frame = CGRect(x: 20, y: 50 - 15, width: kWidth, height: 30)
        title.font = UIFont(name: "Arial-BoldMT", size: 25)
        self.contentView.addSubview(title)
        
        status.frame = CGRect(x: 20, y: title.frame.maxY, width: kWidth, height: 30)
        status.font = UIFont(name: "Arial", size: 20)
        self.contentView.addSubview(status)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
