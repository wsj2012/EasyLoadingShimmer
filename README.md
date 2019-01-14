# EasyLoadingShimmer
这是一个网络请求页面加载等待的的框架，目前饿了么、京东等都是用此动态效果，接入方便快捷。

# Installation

### CocoaPods

The easiest way of installing EasyLoadingShimmer is via [CocoaPods](http://cocoapods.org/). 

```swift
pod 'EasyLoadingShimmer'
```

### Old-fashioned way

- Add `EasyLoadingShimmer.swift` to your project.

# Usage

Effect gif:

![EasyLoadingShimmer](https://github.com/wsj2012/EasyLoadingShimmer/blob/master/screenvideo.gif?raw=true)



Demo:

- 普通View视图添加loading  

```swift
// 普通view视图
	// 在需要展示loading的地方
	EasyLoadingShimmer.startCovering(for: view)
	// 在需要隐藏loading的地方
	EasyLoadingShimmer.stopCovering(for: view)
```

- UITableView中添加loading

```swift
	// UITableView中使用Demo	
	/* 步骤：
	①、设置全局变量numberOfSections、numberOfRows都为0
	②、创建UITableView并注册cell
	③、实现代理(使用步骤①中的变量)
	④、在需要展示loading的地方执行如下startLoading方法。
	*/

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

    override func viewDidAppear(_ animated: Bool) {
        // 传入注册cell的identifier，数组传几个就会在loading时显示几个cell，跟实际返回显示数据无关
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

```

If  you have any questions, you can check the Demo.

# License

EasyLoadingShimmer is licensed under the terms of the MIT License. Please see the [LICENSE](LICENSE) file for full details.

If this code was helpful, I would love to hear from you.