//
//  MTPlainFlowLayout.swift
//  SparkBase
//
//  Created by Apple on 2021/6/30.
//  Copyright © 2021 Spark. All rights reserved.
//

import UIKit

public typealias MTPlainFlowLayoutBlock = (NSInteger) -> Void

@objc public protocol MTCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    @objc optional func backgroundColorForSection(collectionView: UICollectionView, layout: UICollectionViewLayout, section: NSInteger) -> UIColor
    
    @objc optional func cornersForSection(collectionView: UICollectionView, layout: UICollectionViewLayout, section: NSInteger) -> UIRectCorner
    
    @objc optional func radiusForSection(collectionView: UICollectionView, layout: UICollectionViewLayout, section: NSInteger) -> CGFloat
    
    @objc optional func isShowGradient(collectionView: UICollectionView, layout: UICollectionViewLayout, section: NSInteger) -> Bool
}

public class MTPlainFlowLayout: UICollectionViewFlowLayout {
    public var sectionBlock: MTPlainFlowLayoutBlock!

    // 设置停留位置，默认为64(没有导航栏同样设置有效)
    public var naviHeight: CGFloat = 64
    
    // 边距
    public var marginValue: CGFloat = 0
    
    // 存储添加的属性
    private var layoutAttributes: [UICollectionViewLayoutAttributes]?
    
    // 当前section
    private var currentSection: NSInteger = -1
    
    let SectionBackgroundIdentifier: String = "SectionBackgroundIdentifier"
    
    override public init() {
        super.init()
        self.layoutAttributes = []
        self.registDecorationView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registDecorationView() {
        self.register(MTSectionBackgroundView.self, forDecorationViewOfKind: self.SectionBackgroundIdentifier)
    }
    
    override public func prepare() {
        super.prepare()
        self.layoutAttributes?.removeAll()
        self.setSectionBackground()
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // UICollectionViewLayoutAttributes：称它为collectionView中的item（包括cell和header、footer这些）的《结构信息》
        var attributesArray: [UICollectionViewLayoutAttributes] = []
        if let superAttributesArray = super.layoutAttributesForElements(in: rect) {
            attributesArray = superAttributesArray
        }
        
        for attribute in self.layoutAttributes! {
            // 判断两个区域是否有交集
            if rect.intersects(attribute.frame) {
                attributesArray.append(attribute)
            }
        }
        
        // 创建存索引的数组，无符号（正整数），无序（不能通过下标取值），不可重复（重复的话会自动过滤）
        let noneHeaderSections = NSMutableIndexSet()
        // 遍历superArray，得到一个当前屏幕中所有的section数组
        for attributes in attributesArray {
            // 如果当前的元素分类是一个cell，将cell所在的分区section加入数组，重复的话会自动过滤
            if attributes.representedElementCategory == .cell {
                noneHeaderSections.add(attributes.indexPath.section)
            }
        }
        
        // 遍历superArray，将当前屏幕中拥有的header的section从数组中移除，得到一个当前屏幕中没有header的section数组
        // 正常情况下，随着手指往上移，header脱离屏幕会被系统回收而cell尚在，也会触发该方法
        for attributes in attributesArray {
            if let kind = attributes.representedElementKind {
                // 如果当前的元素是一个header，将header所在的section从数组中移除
                if kind == UICollectionElementKindSectionHeader {
                    noneHeaderSections.remove(attributes.indexPath.section)
                }
            }
        }
        
        // 遍历当前屏幕中没有header的section数组
        noneHeaderSections.enumerate { index, _ in
            // 取到当前section中第一个item的indexPath
            let indexPath = NSIndexPath(row: 0, section: index)
            // 获取当前section在正常情况下已经离开屏幕的header结构信息
            if let attributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath as IndexPath) {
                // 如果当前分区确实有因为离开屏幕而被系统回收的header，将该header结构信息重新加入到superArray中去
                attributesArray.append(attributes)
            }
        }
        
        // 遍历superArray，改变header结构信息中的参数，使它可以在当前section还没完全离开屏幕的时候一直显示
        for attributes in attributesArray {
            if attributes.representedElementKind == UICollectionElementKindSectionHeader {
                let section = attributes.indexPath.section
                
                let firstItemIndexPath = NSIndexPath(row: 0, section: section)
                
                var numberOfItemsInSection = 0
                // 得到当前header所在分区的cell的数量
                if let number = self.collectionView?.numberOfItems(inSection: section) {
                    numberOfItemsInSection = number
                }
                
                // 得到最后一个item的indexPath
                let lastItemIndexPath = NSIndexPath(row: max(0, numberOfItemsInSection - 1), section: section)
                
                // 得到第一个item和最后一个item的结构信息
                let firstItemAttributes: UICollectionViewLayoutAttributes!
                let lastItemAttributes: UICollectionViewLayoutAttributes!
                if numberOfItemsInSection > 0 {
                    // cell有值，则获取第一个cell和最后一个cell的结构信息
                    firstItemAttributes = self.layoutAttributesForItem(at: firstItemIndexPath as IndexPath)
                    lastItemAttributes = self.layoutAttributesForItem(at: lastItemIndexPath as IndexPath)
                } else {
                    // cell没值,就新建一个UICollectionViewLayoutAttributes
                    firstItemAttributes = UICollectionViewLayoutAttributes()
                    // 然后模拟出在当前分区中的唯一一个cell，cell在header的下面，高度为0，还与header隔着可能存在的sectionInset的top
                    let itemY = attributes.frame.maxY + self.sectionInset.top
                    firstItemAttributes.frame = CGRect(x: 0, y: itemY, width: 0, height: 0)
                    // 因为只有一个cell，所以最后一个cell等于第一个cell
                    lastItemAttributes = firstItemAttributes
                }
                
                // 获取当前header的frame
                var rect = attributes.frame
                
                // 当前的滑动距离 + 因为导航栏产生的偏移量，默认为64（如果app需求不同，需自己设置）
                var offset_Y: CGFloat = 0
                if let y = self.collectionView?.contentOffset.y {
                    offset_Y = y
                }
                offset_Y = offset_Y + self.naviHeight
                // 第一个cell的y值 - 当前header的高度 - 可能存在的sectionInset的top
                let headerY = firstItemAttributes.frame.origin.y - rect.size.height - self.sectionInset.top
                // 哪个大取哪个，保证header悬停
                // 针对当前header基本上都是offset更加大，针对下一个header则会是headerY大，各自处理
                let maxY = max(offset_Y, headerY)
                
                // 最后一个cell的y值 + 最后一个cell的高度 + 可能存在的sectionInset的bottom - 当前header的高度
                // 当当前section的footer或者下一个section的header接触到当前header的底部，计算出的headerMissingY即为有效值
                let headerMissingY = lastItemAttributes.frame.maxY + self.sectionInset.bottom - rect.size.height
                // 给rect的y赋新值，因为在最后消失的临界点要跟谁消失，所以取小
                rect.origin.y = min(maxY, headerMissingY)
                
                if headerY <= offset_Y && offset_Y <= headerMissingY {
                    if section != self.currentSection {
                        self.currentSection = section

                        weak var weakSelf = self
                        if self.sectionBlock != nil {
                            weakSelf?.sectionBlock(self.currentSection)
                        }
                    }
                }
                // 给header的结构信息的frame重新赋值
                attributes.frame = rect

                // 如果按照正常情况下,header离开屏幕被系统回收，而header的层次关系又与cell相等，如果不去理会，会出现cell在header上面的情况
                // 通过打印可以知道cell的层次关系zIndex数值为0，我们可以将header的zIndex设置成1，如果不放心，也可以将它设置成非常大
                attributes.zIndex = 1024
            }
        }
        
        return attributesArray
    }

    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public func sectionBlockCallBack(block: @escaping MTPlainFlowLayoutBlock) {
        self.sectionBlock = block
    }
    
    // 设置section的背景色
    func setSectionBackground() {
        // 获取collectionView的代理
        guard let delegate = self.collectionView?.delegate else {
            return
        }
        // 没遵守这个协议就不再往下设置
        if delegate.conforms(to: MTCollectionViewDelegateFlowLayout.self) == false {
            return
        }
        // collectionView有多少组
        let numberOfSections = self.collectionView?.numberOfSections ?? 0
        if numberOfSections == 0 {
            return
        }
        // 循环遍历各组 设置添加的属性
        for section in 0 ..< numberOfSections {
            // 一组cell的Item
            let numberOfItems = self.collectionView?.numberOfItems(inSection: section) ?? 0
            if numberOfItems <= 0 {
                continue
            }
            // 每一组第一个item的Attributes
            let firstItem = self.layoutAttributesForItem(at: IndexPath(item: 0, section: section))
            // 每一组最后一个item的Attributes
            let lastItem = self.layoutAttributesForItem(at: IndexPath(item: numberOfItems - 1, section: section))
            // 满足条件 结束本次循环执行下一次
            if firstItem == nil || lastItem == nil {
                continue
            }
            // 实现了insetForSectionAt
            if delegate.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:))) {
                let inset = (delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(self.collectionView!, layout: self, insetForSectionAt: section)
                self.sectionInset = inset!
            }
            // 获取第一个和最后一个item的联合frame ，得到的就是这一组的frame
            var sectionFrame: CGRect = firstItem!.frame.union(lastItem!.frame)
            sectionFrame.origin.x -= self.sectionInset.left - self.marginValue
            sectionFrame.origin.y -= self.sectionInset.top
            // 横向滚动
            if self.scrollDirection == .horizontal {
                // 计算组的宽的时候要把缩进进去的距离加回来 因为缩进是内容缩进
                sectionFrame.size.width += self.sectionInset.left + self.sectionInset.right
                // 横向滚动的时候 组的高就是collectionView的高
                sectionFrame.size.height = self.collectionView!.frame.size.height
            } else {
                sectionFrame.size.width = self.collectionView!.frame.size.width - 2 * self.marginValue
                sectionFrame.size.height += self.sectionInset.top + self.sectionInset.bottom
            }
            // 根据自定义的CollectionViewSectionBackground 装饰View初始化一个自定义的CollectionLayoutAttributes
            let attribute = MTSectionBackgroundAttributes(forDecorationViewOfKind: SectionBackgroundIdentifier, with: IndexPath(item: 0, section: section))
            attribute.frame = sectionFrame
            attribute.zIndex = -1
            // 控制背景色改变
            if delegate.responds(to: #selector(MTCollectionViewDelegateFlowLayout.isShowGradient(collectionView:layout:section:))) {
                attribute.isShow = (delegate as? MTCollectionViewDelegateFlowLayout)?.isShowGradient?(collectionView: self.collectionView!, layout: self, section: section)
            }
            // 实现了背景色
            if delegate.responds(to: #selector(MTCollectionViewDelegateFlowLayout.backgroundColorForSection(collectionView:layout:section:))) {
                attribute.backgroundColor = (delegate as? MTCollectionViewDelegateFlowLayout)?.backgroundColorForSection?(collectionView: self.collectionView!, layout: self, section: section)
            }
            // 实现了圆角
            if delegate.responds(to: #selector(MTCollectionViewDelegateFlowLayout.cornersForSection(collectionView:layout:section:))) {
                attribute.corners = (delegate as? MTCollectionViewDelegateFlowLayout)?.cornersForSection?(collectionView: self.collectionView!, layout: self, section: section)
            }
            // 自定义了圆角大小
            if delegate.responds(to: #selector(MTCollectionViewDelegateFlowLayout.radiusForSection(collectionView:layout:section:))) {
                attribute.cornerRadii = (delegate as? MTCollectionViewDelegateFlowLayout)?.radiusForSection?(collectionView: self.collectionView!, layout: self, section: section)
            }
            
            self.layoutAttributes?.append(attribute)
        }
    }

    override public func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == self.SectionBackgroundIdentifier {
            return self.layoutAttributes![indexPath.section]
        }
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
}
