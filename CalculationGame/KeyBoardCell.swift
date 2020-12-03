//
//  KeyBoardCell.swift
//  CalculationGame
//
//  Created by Huy Than Duc on 30/11/2020.
//

import UIKit

class KeyBoardCell: UICollectionViewCell {
    let Image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func styleKeyBoard(item: ButtonCalculation) {
        addSubview(Image)
        Image.frame = bounds
        if let image = UIImage(named: item.image) {
            Image.image = image
        }
    }
}
