//
//  TableViewController.swift
//  EasyLoadingShimmer
//
//  Created by sj_w on 2019/1/11.
//  Copyright © 2019年 sj_w. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let t = UITableView.init(frame: view.bounds, style: .plain)
        t.dataSource = self
        t.delegate = self
        t.estimatedRowHeight = 150
        t.rowHeight = 150
        t.register(CustomCell.self, forCellReuseIdentifier: "Cell1")
        return t
    }()
    
    var numberOfRows: Int =  0
    var numberOfSections: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.play, target: self, action: #selector(startLoading))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(stopLoading))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        EasyLoadingShimmer.startCovering(for: tableView, with: ["Cell1", "Cell1", "Cell1", "Cell1", "Cell1"])
    }
    
    @objc func startLoading() {
        numberOfSections = 0
        numberOfRows = 0
        tableView.reloadData()
        EasyLoadingShimmer.startCovering(for: tableView, with: ["Cell1", "Cell1", "Cell1", "Cell1", "Cell1"])
    }
    
    @objc func stopLoading() {
        numberOfSections = 1
        numberOfRows = 10
        tableView.reloadData()
        EasyLoadingShimmer.stopCovering(for: tableView)
    }

}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
