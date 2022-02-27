//
//  WDTagFlowLayout.swift
//  test
//
//  Created by cs_sy on 2022/2/27.
//

import UIKit

class DDTagFlowLayout: UICollectionViewFlowLayout {
    // 存储所有cell的布局属性
    var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // collectionView实际大小
    private var contentSize: CGSize = CGSize.zero
    
    override var collectionViewContentSize: CGSize {
        return CGSize.init(width: self.collectionView!.frame.width, height: contentSize.height)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // 1.预加载布局属性
    override func prepare() {
        super.prepare()
        // 状态清空
        contentSize = CGSize.zero
        layoutAttributes.removeAll()
        // 遍历计算布局
        // tags count
        let itemNum: Int = self.collectionView!.numberOfItems(inSection: 0)
        for i in 0..<itemNum {
            let layoutAttr = layoutAttributesForItem(at: IndexPath.init(row: i, section: 0))
            layoutAttributes.append(layoutAttr!)
        }
    }
    
    // 2.单个item 布局属性调整
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        // 2.1 获取item的size 拿layout代理方法sizeForItem的计算结果
        var size = self.itemSize
        if self.collectionView!.delegate != nil  && self.collectionView!.delegate!.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:sizeForItemAt:)))  {
            
            let flowLayoutDelegate = self.collectionView!.delegate as! UICollectionViewDelegateFlowLayout
            size = flowLayoutDelegate.collectionView!(self.collectionView!, layout: self, sizeForItemAt: indexPath)
        }
        
        // 2.2 初始化临时变量
        var frame = CGRect.zero
        // 第一个元素坐标位 默认当前要计算的item是第一个
        var x: CGFloat = self.sectionInset.left
        var y: CGFloat = self.sectionInset.top
        // collectionView宽度
        let collectionViewWidth: CGFloat = self.collectionView!.bounds.width
           
        // 2.3 调整布局
        if layoutAttributes.count > 0 {
            // 如果不是第一个 获取上一个item
            let preAttr = layoutAttributes.last!
            
            // 前一个maxX + item间隔 + 当前width + 边距 > width  --> 调整 y 换行显示
            if preAttr.frame.maxX + self.minimumInteritemSpacing + size.width + self.sectionInset.right > collectionViewWidth {
                y = preAttr.frame.maxY + self.minimumLineSpacing
            }else{
                // 当前行显示
                x = preAttr.frame.maxX + self.minimumInteritemSpacing
                y = preAttr.frame.minY
            }
        }
         
        frame = CGRect(x: x, y: y, width: size.width, height: size.height)
        
        // 2.4 更新contentSize属性
        contentSize.width = frame.maxX + self.sectionInset.right
        contentSize.height = frame.maxY + self.sectionInset.bottom
        
        // 2.5 返回item对应的布局属性
        let layoutAttr = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        layoutAttr.frame = frame
        return layoutAttr
    }
    
    // 3.返回所有布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
}
