//
//  CustomCell.swift
//  EasyLoadingShimmer
//
//  Created by sj_w on 2019/1/12.
//  Copyright © 2019年 sj_w. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    lazy var imgView: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "test"))
        img.frame = CGRect(x: 12, y: 0, width: 80, height: 80)
        return img
    }()
    
    lazy var label: UILabel = {
        let l = UILabel.init(frame: CGRect(x: imgView.bounds.origin.x + imgView.bounds.size.width + 12, y: 70, width: 200, height: 40))
        l.textAlignment = .left
        l.text = "这是一段测试文案"
        return l
    }()
    
    lazy var switcher: UISwitch = {
        let s = UISwitch.init(frame: CGRect(x: 150, y: 120, width: 100, height: 20))
        s.isOn = true
        return s
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 如果不设此frame， 在绘制loading时将只能获取到默认的frame，高度变成了44
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 150)
        
        contentView.addSubview(imgView)
        contentView.addSubview(label)
        contentView.addSubview(switcher)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
