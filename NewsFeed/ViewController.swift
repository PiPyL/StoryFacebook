//
//  ViewController.swift
//  NewsFeed
//
//  Created by flydino on 11/19/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let colors: [UIColor] = [.black, .blue, .brown, .cyan, .orange, .red, .green, .yellow, .systemPink]
    
    private let height: CGFloat = 100
    private let width: CGFloat = 60
    private let widthPoint: CGFloat = 45
    private let leadingMin: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "MyCardCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyCardCollectionView")
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: width + 10, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyCardCollectionView", for: indexPath) as? MyCardCollectionView {
                headerView.cardView.backgroundColor = .green
                headerView.viewWidth.constant = width
//                headerView.cardView.layer.cornerRadius = 12
                return headerView
            }
            return UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFeedCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = collectionView.contentOffset.x
        guard let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0)) as? MyCardCollectionView else { return }
        
        let newHeight = height - x < widthPoint ? widthPoint : height - x
        headerView.viewHeight.constant = newHeight
        
        let newWidth = width - x < widthPoint ? widthPoint : width - x
        headerView.viewWidth.constant = newWidth
        
        var cornerRadius = newWidth / 2 * x * 0.1
        cornerRadius = cornerRadius > newWidth / 2 ? newWidth / 2 : cornerRadius
        headerView.cardView.roundCorners([.topRight, .bottomRight], radius: cornerRadius)
//        headerView.cardView.roundCorners([.topLeft, .bottomLeft], radius: cornerRadius)
//        headerView.cardView.roundCorners([.topLeft, .bottomLeft], radius: newWidth / 2 - cornerRadius)

        let leadingSpacing = (leadingMin - x * 0.2) > leadingMin ? leadingMin : (leadingMin - x * 0.2)
        headerView.viewLeading.constant = leadingSpacing > 0 ? leadingSpacing : 0
        
        print(newWidth / 2 - cornerRadius)
    }
}

class NewsFeedCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}

