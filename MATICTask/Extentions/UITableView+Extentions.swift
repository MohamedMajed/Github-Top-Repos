//
//  UITableView+Extentions.swift
//  MATICTask
//
//  Created by Mohamed Maged on 11/04/2022.
//

import UIKit

public extension UITableView {
    func register(cellType types: UITableViewCell.Type...) {
        types.forEach { type in
            let name = String(describing: type)
            let bundle = Bundle(for: type)
            if bundle.path(forResource: name, ofType: "nib") != nil {
                register(UINib(nibName: name, bundle: bundle), forCellReuseIdentifier: name)
            } else {
                register(type, forCellReuseIdentifier: name)
            }
        }
    }
 
    func dequeueReusableCell<T: UITableViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
    }
 
    func register(headerFooterViewType types: UITableViewHeaderFooterView.Type...) {
        types.forEach { type in
            let name = String(describing: type)
            let bundle = Bundle(for: type)
            if bundle.path(forResource: name, ofType: "nib") != nil {
                register(UINib(nibName: name, bundle: bundle), forHeaderFooterViewReuseIdentifier: name)
            } else {
                register(type, forHeaderFooterViewReuseIdentifier: name)
            }
        }
    }
 
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withType type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as! T
    }
}
 
public extension UICollectionReusableView {
    enum Kind: String {
        case header
        case footer
        
 
        public var rawValue: String {
            switch self {
                case .header:
                    return UICollectionView.elementKindSectionHeader
                case .footer:
                    return UICollectionView.elementKindSectionFooter
            }
        }
 
 
        public init?(rawValue: String) {
            switch rawValue {
                case UICollectionView.elementKindSectionHeader:
                    self = .header
                case UICollectionView.elementKindSectionFooter:
                    self = .footer
                default:
                    return nil
            }
        }
 
 
    }
}
