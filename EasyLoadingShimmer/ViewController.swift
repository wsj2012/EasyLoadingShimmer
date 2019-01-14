//
//  ViewController.swift
//  EasyLoadingShimmer
//
//  Created by sj_w on 2019/1/11.
//  Copyright © 2019年 sj_w. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var headIcon: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "test"))
        img.frame = CGRect(x: 20, y: 120, width: 80, height: 80)
        return img
    }()
    
    lazy var nameFile: UITextField = {
        let field = UITextField.init(frame: CGRect(x: 20 + 80 + 12, y: 125, width: 180, height: 27))
        field.text = "黑客布鲁特李"
        return field
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 20 + 80 + 12, y: 200 - 24, width: 168, height: 20))
        label.textAlignment = .left
        label.text = "23分钟前 来自公众号"
        return label
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView(frame: CGRect(x: 20, y: 220, width: UIScreen.main.bounds.size.width - 40, height: 90))
        tv.text = "为感谢”程序员大咖秀“的各位朋友🤗，咖君决定持续写出更多有质量的文章👄。感谢支持🤝我是Dwyane，学习管理中，热爱技术，热爱生活。我爱你们"
        tv.textAlignment = .left
        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view.addSubview(headIcon)
        view.addSubview(nameFile)
        view.addSubview(textView)
        view.addSubview(subLabel)

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.play, target: self, action: #selector(startLoading))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(stopLoading))
    }
    
    @objc func startLoading() {
        EasyLoadingShimmer.startCovering(for: view)
    }
    
    @objc func stopLoading() {
        EasyLoadingShimmer.stopCovering(for: view)
    }
    
}

