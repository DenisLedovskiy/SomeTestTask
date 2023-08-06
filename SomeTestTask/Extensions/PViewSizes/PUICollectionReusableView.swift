//
//  PUICollectionReusableView.swift
//  SomeTestTask
//
//  Created by Денис Ледовский on 04.08.2023.
//

import Foundation
import UIKit

class PCollectionReusableView: UICollectionReusableView, PViewSizesProtocol  {
    static var id: String {
        return String(describing: self)
    }

    class var elementKind: String {
        return UICollectionView.elementKindSectionHeader
    }

    static var size: CGSize {
        return CGSize(width: 0, height: height)
    }

    class var height: CGFloat {
        return 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        //object configuration:
    }

    static func register(_ collectionView: UICollectionView) {
        collectionView.register(Self.self, forSupplementaryViewOfKind: Self.elementKind, withReuseIdentifier: Self.id)
    }

    static func getView(_ collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableSupplementaryView(ofKind: Self.elementKind, withReuseIdentifier: Self.id, for: indexPath) as! Self
    }
}
