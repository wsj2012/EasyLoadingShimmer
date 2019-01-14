//
//  EasyLoadingShimmer.swift
//  EasyLoadingShimmer
//
//  Created by 王树军(金融壹账通客户端研发团队) on 2019/1/11.
//  Copyright © 2019年 王树军(金融壹账通客户端研发团队). All rights reserved.
//

import UIKit

open class EasyLoadingShimmer: NSObject {
    
    /// 拿来遮盖 toCoveriView 的覆盖层
    private lazy var viewCover: UIView = {
        let v = UIView.init()
        v.tag = 1987
        v.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return v
    }()
    
    /// 颜色渐变层
    private var colorLayer: CAGradientLayer?
    /// 用于显示建层层的mask
    private var maskLayer: CAShapeLayer?
    /// 总的覆盖路径
    private lazy var totalCoverablePath: UIBezierPath = {
        let p = UIBezierPath.init()
        return p
    }()
    
    private var addOffsetflag: Bool?

    /// 开始覆盖子控件 如果view是UITableView才传identifiers
    public static func startCovering(for view: UIView?, with identifiers: [String]? = ["Cell1", "Cell1", "Cell1", "Cell1", "Cell1"]) {
        EasyLoadingShimmer.init().coverSubviews(view: view, with: identifiers)
    }
    
    /// 停止覆盖子控件
    public static func stopCovering(for view: UIView?) {
        EasyLoadingShimmer.init().removeSubviews(view: view)
    }
    
    private func coverSubviews(view: UIView?, with identifiers: [String]?) {
        guard let v = view else {
            NSException(name: NSExceptionName(rawValue: "coverSubviews"), reason: "[(void)coverSubviews:(UIView *)view]:view is nil", userInfo: nil).raise()
            return
        }
        
        for subV in v.subviews {
            if subV.tag == 1987 {
                return
            }
        }
        
//        let coverableCellsIds: [String] = ["Cell1", "Cell1", "Cell1", "Cell1", "Cell1"]
        if let coverableCellsIds = identifiers {
            if v.isMember(of: UITableView.self) {
                for (index, _) in coverableCellsIds.enumerated() {
                    getTableViewPath(view: v, index: index, coverableCellsIds: coverableCellsIds)
                }
                addCover(view: v)
                return
            }
        }
        
        v.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        if v.subviews.count > 0 {
            for subV in v.subviews {
                var defaultCoverblePath = UIBezierPath(roundedRect: subV.bounds, cornerRadius: subV.frame.size.height / 2.0)
                if subV.isMember(of: UILabel.self) || subV.isMember(of: UITextView.self) {
                    defaultCoverblePath = UIBezierPath(roundedRect: subV.bounds, cornerRadius: 4)
                }
                let relativePath = defaultCoverblePath
                let offsetPoint = subV.convert(subV.bounds, to: v).origin
                subV.layoutIfNeeded()
                relativePath.apply(CGAffineTransform(translationX: offsetPoint.x, y: offsetPoint.y))
                totalCoverablePath.append(relativePath)
            }
            addCover(view: v)
        }
    }
    
    private func removeSubviews(view: UIView?) {
        guard let v = view else {
            NSException(name: NSExceptionName(rawValue: "removeSubviews"), reason: "[(void)removeSubviews:(UIView *)view]:view is nil", userInfo: nil).raise()
            return
        }
        for subV in v.subviews {
            if subV.tag == 1987 {
                subV.removeFromSuperview()
                break
            }
        }
    }
    
    
    private func getTableViewPath(view: UIView, index: Int, coverableCellsIds: [String]) {
        let tableView = view as! UITableView
        let headerOffset = EasyLoadingShimmer.getHeaderOffset()
        if let cell = tableView.dequeueReusableCell(withIdentifier: coverableCellsIds[index]) {
            cell.frame = CGRect(x: 0, y: cell.frame.size.height * CGFloat(index) + headerOffset, width: cell.frame.size.width, height: cell.frame.size.height)
            cell.layoutIfNeeded()
            for cellSub in cell.contentView.subviews {
                let defaultCoverblePath = UIBezierPath(roundedRect: cellSub.bounds, cornerRadius: cellSub.frame.size.height / 2.0)
                var offsetPoint = cellSub.convert(cellSub.bounds, to: tableView).origin
                if index == 0, offsetPoint.y > cellSub.frame.origin.y {
                    addOffsetflag = true
                }
                if let flag = addOffsetflag, flag {
                    offsetPoint.y -= headerOffset
                }
                cellSub.layoutIfNeeded()
                defaultCoverblePath.apply(CGAffineTransform(translationX: offsetPoint.x, y: offsetPoint.y + headerOffset))
                totalCoverablePath.append(defaultCoverblePath)
            }
        }
        
    }
    
    private func addCover(view: UIView) {
        viewCover.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(viewCover)
        let colorLayer = CAGradientLayer.init()
        colorLayer.frame = view.bounds
        colorLayer.startPoint = CGPoint(x: -1.4, y: 0)
        colorLayer.endPoint = CGPoint(x: 1.4, y: 0)
        colorLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.01).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.009).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.04).cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.02).cgColor]
        colorLayer.locations = [NSNumber(value: Float(colorLayer.startPoint.x)), NSNumber(value: Float(colorLayer.startPoint.x)), NSNumber(value: 0), NSNumber(value: 0.2), NSNumber(value: 1.2)]
        viewCover.layer.addSublayer(colorLayer)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = totalCoverablePath.cgPath
        maskLayer.fillColor = UIColor.red.cgColor
        colorLayer.mask = maskLayer
        // 动画 animate
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = colorLayer.locations
        animation.toValue = [NSNumber(value: 0), NSNumber(value: 1), NSNumber(value: 1), NSNumber(value: 1.2), NSNumber(value: 1.2)]
        animation.duration = 0.9
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        colorLayer.add(animation, forKey: "locations-layer")
    }
    
}

extension EasyLoadingShimmer {
    
    static let kScreenHeight = UIScreen.main.bounds.size.height
    // X h=812,XR & XR max h=896
    static let safeAreaTopHeight = (EasyLoadingShimmer.kScreenHeight == 812.0 || EasyLoadingShimmer.kScreenHeight == 896.0) ? 88.0 : 64.0
    
    // 增加适配 x xr xr max
    static func getHeaderOffset() -> CGFloat {
        if let _ = EasyLoadingShimmer.currentViewController() {
            return CGFloat(EasyLoadingShimmer.safeAreaTopHeight)
        }else {
            return 0
        }
    }
    
    static func currentViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.keyWindow
        var viewController = keyWindow?.rootViewController
        while let vc = viewController, vc.presentedViewController != nil {
            viewController = vc.presentedViewController
            if vc.isKind(of: UINavigationController.self) {
                viewController = (vc as! UINavigationController).visibleViewController
            }else if vc.isKind(of: UITabBarController.self) {
                viewController = (vc as! UITabBarController).selectedViewController
            }
        }
        return viewController
    }
}
