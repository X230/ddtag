//
//  WDTagCell.swift
//  test
//
//  Created by cs_sy on 2022/2/27.
//

import UIKit

class DDTagCell: UICollectionViewCell {
    lazy var lblTag: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 14)
        lbl.backgroundColor = UIColor(rgb: 0xf5f5f5)
        return lbl
    }()

    // 一滚动 cell位置就错乱
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        lblTag.frame = contentView.bounds
//        contentView.addSubview(lblTag)
//        wd_View_Set_Corner(view: lblTag, radius: 6)
//    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //------
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lblTag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lblTag.frame = contentView.bounds
        dd_View_Set_Corner(view: lblTag, radius: 6)
    }
    //------
    
    func setupStyle(isSelected: Bool){
        if isSelected{
            dd_View_Set_Border(mview: lblTag, borderW: 0.5, borderColor: UIColor(rgb: 0x8200FF))
            lblTag.backgroundColor = UIColor.white
            lblTag.textColor = UIColor(rgb: 0x8200FF)
        }
        else{
            dd_View_Set_Border(mview: lblTag, borderW: 0, borderColor: UIColor.clear)
            lblTag.backgroundColor = UIColor(rgb: 0xf5f5f5)
            lblTag.textColor = UIColor(rgb: 0x222222)
        }
    }
}

extension DDTagCell{
    func dd_View_Set_Corner(view: UIView, radius: CGFloat){
        view.layer.cornerRadius = radius;
        view.layer.masksToBounds = true;
    }


    func dd_View_Set_Border(mview: UIView, borderW: CGFloat, borderColor: UIColor){
        mview.layer.borderWidth = borderW
        mview.layer.borderColor = borderColor.cgColor;
    }
}
