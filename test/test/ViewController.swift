//
//  ViewController.swift
//  test
//
//  Created by dai xu on 2022/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tagsArr: [String] = ["水电费水电费", "多少分", "飞潍坊市", "闻风丧胆", "电饭锅","给弟弟发个", "富贵花风格", "隔热", "个人股","挂号费干活", "个让哥哥", "大范甘迪风格", "二哥","给", "个人个人", "嗯", "古典风格地方","汉釜宫和", "很反感", "还让他让他", "富贵花富贵花","发个高合金钢", "干活", "激光焊接干活", "就","加油", "还让他", "刚好激光焊接", "好几块","烤鱼", "烤鱼烤鱼u英科宇", "快回家", "哭语音","人体艺", "今天有局", "很艰苦呀", "一天","几套衣服他", "二个人个人", "费伟伟", "广发华福干活","干豆腐不太热", "人烟浩穰天好热天", "复合弓", "润体乳他","今天有有人", "还让他让他", "额个热热", "讨厌就讨厌","金泰妍姐姐", "一样一样", "犹犹豫豫", "今天已经同意","加油", "今天有太阳", "贝多芬病毒", "发年货女娲娘娘"]
    
    lazy var collectionV: UICollectionView = {
        let layout = DDTagFlowLayout()
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        cv.register(DDTagCell.self, forCellWithReuseIdentifier: "DDTagCell")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var btnCommit:UIButton  = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "icon_new_login_commit"), for: .normal)
        btn.addTarget(self, action: #selector(btnCommitClicked), for: .touchUpInside)
        return btn
    }()
    
    // 最大可选数量
    private let maxCount: Int = 4
    // 已选择集合
    var selTagArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionV)
        view.addSubview(btnCommit)
        collectionV.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 300)
        btnCommit.frame = CGRect(x: 150, y: 500, width: 100, height: 40)
    }
    
    @objc func btnCommitClicked(){
        collectionV.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: DDTagCell = collectionV.dequeueReusableCell(withReuseIdentifier: "DDTagCell", for: indexPath) as! DDTagCell
        let tag = tagsArr[indexPath.item]
        cell.lblTag.text = tag
        cell.setupStyle(isSelected: selTagArr.contains(tag))
        return cell
    }
    
    // 点击切换样式
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let cell: DDTagCell = collectionView.cellForItem(at: indexPath) as! DDTagCell
        let tagClicked = tagsArr[indexPath.row]
        if selTagArr.contains(tagClicked){
            if let i = selTagArr.firstIndex(of: tagClicked){
                selTagArr.remove(at: i)
            }
            cell.setupStyle(isSelected: false)
        }
        else if selTagArr.count == maxCount{
            return
        }
        else{
            selTagArr.append(tagClicked)
            cell.setupStyle(isSelected: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        // 计算宽度  高度固定40
        return CGSize(width: labelWidth(tagsArr[indexPath.item] , 40), height: 40)
    }
    
    // 计算文本宽度
    func labelWidth(_ text: String, _ height: CGFloat) -> CGFloat{
        let size = CGSize(width: 2000, height: height)
        let font = UIFont.systemFont(ofSize: 14)
        let attr = [NSAttributedString.Key.font: font]
        let lblSize = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr, context: nil)
        return CGFloat.minimum(lblSize.width + 20, collectionV.frame.width)
    }
}


