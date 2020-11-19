//
//  MyCardCollectionView.swift
//  NewsFeed
//
//  Created by flydino on 11/19/20.
//

import UIKit

class MyCardCollectionView: UICollectionReusableView {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewLeading: NSLayoutConstraint!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
