//
//  ZLUserDetailDongTaiCell.swift
//  zhangyanlfNews
//
//  Created by 张彦林 on 2018/12/6.
//  Copyright © 2018 zhangyanlf.cn. All rights reserved.
//

import UIKit
import IBAnimatable

class ZLUserDetailDongTaiCell: UITableViewCell, RegisterCellFromNib {
    
    var dongtai = ZLUserDetailDongtai() {
        didSet{
            avatarImageView.kf.setImage(with: URL(string: dongtai.user.avatar_url))
            nameLabel.text = dongtai.user.screen_name
            modifyTimeLabel.text = "· " + dongtai.createTime
            likeButton.setTitle(dongtai.diggCount, for: .normal)
            commentButton.setTitle(dongtai.commentCount, for: .normal)
            forwardButton.setTitle(dongtai.forwardCount, for: .normal)
            areaLabel.text = dongtai.brand_info + " " + dongtai.position.position
            readCountLabel.text = dongtai.readCount + "阅读"
            
            contentLabel.attributedText = dongtai.attributedContent
            contentLabelHeight.constant = dongtai.contentH
            allContentLabel.isHidden = dongtai.attributedCntentHeight == 110 ? false : true
            
            //判断middleView cell重用机制   防止数据混乱
            if #available(iOS 11.0, *) {
                if middleView.contains(postVideoArticleView){
                    postVideoArticleView.removeFromSuperview()
                }
            } else {
                // Fallback on earlier versions
               
            }

            if #available(iOS 11.0, *) {
                if middleView.contains(collectionView){
                    collectionView.removeFromSuperview()
                }
            } else {
                // Fallback on earlier versions
            }
            
            if #available(iOS 11.0, *) {
                if middleView.contains(originThreadView){
                    originThreadView.removeFromSuperview()
                }
            } else {
                // Fallback on earlier versions
            }
           
            
            switch dongtai.item_type {
            case .postVideoOrArticle, .postVideo, .answerQuestion, .proposeQuestion, .forwardArticle, .postContentAndVideo:  // 发布了文章或者视频
                    middleView.addSubview(postVideoArticleView)
                    postVideoArticleView.frame = CGRect(x: 15, y: 0, width: screenWidth - 30, height: middleView.height)
                postVideoArticleView.group = dongtai.group
                case .postContent, .postSmallVideo:  // 发布了文字内容
                    middleView.addSubview(collectionView)
                    collectionView.frame = CGRect(x: 15, y: 0, width: dongtai.collectionViewW, height: dongtai.collectionViewH)
                    collectionView.thumbImageList = dongtai.thumb_image_list
                case .commentOrQuoteContent, .commentOrQuoteOthers:  // 引用或评论
                   middleView.addSubview(originThreadView)
                originThreadView.frame = CGRect(x: 15, y: 0, width: dongtai.collectionViewW, height: dongtai.origin_thread.height)
                originThreadView.originThread = dongtai.origin_thread
                print("")
            }
            layoutIfNeeded()
        }
    }
    
    
    ///懒加载 发布视频或文章
    private lazy var postVideoArticleView : ZLPostVideoArticleView = {
        let postVideoArticleView = ZLPostVideoArticleView.loadViewFromNib()
        return postVideoArticleView
    }()
    
     ///懒加载 评论或引用
    private lazy var originThreadView: ZLDongtaiOriginThreadView = {
        let originThreadView = ZLDongtaiOriginThreadView.loadViewFromNib()
        return originThreadView
    }()
    
     ///懒加载 collectionView
    private lazy var collectionView: ZLDongtaiCollectionView = {
        let collectionView = ZLDongtaiCollectionView.loadViewFromNib()

        collectionView.theme_backgroundColor = "colors.cellBackgroundColor"
        return collectionView
    }()
//    private lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: DongtaiCollectionViewFlowLayout())
//        collectionView.zl_registerCell(cell: ZLDongtaiCollectionViewCell.self)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isScrollEnabled = false
//        collectionView.theme_backgroundColor = "colors.cellBackgroundColor"
//        return collectionView
//    }()

    
    
    @IBOutlet weak var separatorView: UIView!
    /// 头像
    @IBOutlet weak var avatarImageView: AnimatableImageView!
    /// 用户名
    @IBOutlet weak var nameLabel: UILabel!
    /// 修改时间
    @IBOutlet weak var modifyTimeLabel: UILabel!
    /// 更多按钮
    @IBOutlet weak var moreButton: UIButton!
    /// 喜欢按钮
    @IBOutlet weak var likeButton: UIButton!
    /// 评论按钮
    @IBOutlet weak var commentButton: UIButton!
    /// 转发按钮
    @IBOutlet weak var forwardButton: UIButton!
    /// 位置，阅读数量
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    
    @IBOutlet weak var separatorView2: UIView!
    /// 内容
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentLabelHeight: NSLayoutConstraint!
    /// 全文
    @IBOutlet weak var allContentLabel: UILabel!
    /// 中间的 view
    @IBOutlet weak var middleView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        //separatorView2.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
        nameLabel.theme_textColor = "colors.grayColor150"
        modifyTimeLabel.theme_textColor = "colors.grayColor150"
        likeButton.theme_setTitleColor("colors.black", forState: .normal)
        commentButton.theme_setTitleColor("colors.black", forState: .normal)
        forwardButton.theme_setTitleColor("colors.black", forState: .normal)
        likeButton.theme_setImage("images.feed_like_24x24_", forState: .normal)
        likeButton.theme_setImage("images.feed_like_press_24x24_", forState: .selected)
        commentButton.theme_setImage("images.comment_feed_24x24_", forState: .normal)
        moreButton.theme_setImage("images.morebutton_dynamic_14x8_", forState: .normal)
        moreButton.theme_setImage("images.morebutton_dynamic_press_14x8_", forState: .highlighted)
        forwardButton.theme_setImage("images.feed_share_24x24_", forState: .normal)
       // contentLabel.theme_textColor = "colors.black"
        //allContentLabel.theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


