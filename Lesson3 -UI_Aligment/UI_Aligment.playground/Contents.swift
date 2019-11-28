//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

/*:
 - UIView()
 - UIImageView()
 - UILabel()
 - UIButton()
 */
class MyViewController: UIViewController {
    
    let cardView        = UIView()
    let videoImageView  = UIImageView()
    let titleLabel      = UILabel()
    let watchButton     = UIButton()
    let animateButton   = UIButton()
    
    var cardViewBottomConstraint: NSLayoutConstraint!
    
    // 每一次创建 自动调用
    override func loadView() {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.view = view
        setupCardView()
    }
    
    func setupCardView() {
        view.addSubview(cardView)
        cardView.backgroundColor    = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cardView.layer.cornerRadius = 12
        cardView.addDownSwipeListenner(target: self, action: #selector(swipeCard))
        
        //cardView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        //cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        cardViewBottomConstraint = cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 600)
        cardViewBottomConstraint.isActive = true
        
        setupAnimateButton()
        setupVideoImageView()
        setupTitleLabel()
        setupWatchButton()
    }
    
    func setupAnimateButton() {
        view.addSubview(animateButton)
        animateButton.setTitle("Animate", for: .normal)
        animateButton.setTitleColor(.white, for: .normal)
        animateButton.backgroundColor    = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        animateButton.layer.cornerRadius = 12
        animateButton.addTarget(self, action: #selector(animateCard), for: .touchDown)
        
        /*
         练习（1）
         - 左边 = 30
         - 右边 = 30
         - 高度 = 50
         - 顶部 = 100
         */
        
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        animateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        animateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        animateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        animateButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    func setupVideoImageView() {
        cardView.addSubview(videoImageView)
        videoImageView.layer.cornerRadius  = 12
        videoImageView.layer.masksToBounds = true
        videoImageView.image               = UIImage(named: "0.jpeg")
        
        /*
         练习（2）
         - 左边     = 30
         - 右边     = 30
         - 高度/宽度 = 9/16
         - 顶部     = 50
         */
        
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        videoImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        videoImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        videoImageView.heightAnchor.constraint(equalTo: videoImageView.widthAnchor, multiplier: 9.0/16.0).isActive = true
        videoImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 50).isActive = true
    }
    
    func setupTitleLabel() {
        cardView.addSubview(titleLabel)
        titleLabel.text             = "2019 Setup"
        titleLabel.font             = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor        = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        titleLabel.textAlignment    = .center
        
        /*
         练习（3）
         - 左边 = 10
         - 右边 = 10
         - 高度 = 22
         - 顶部 = 0
         */
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        titleLabel.topAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: 18).isActive = true
    }
    
    func setupWatchButton() {
        cardView.addSubview(watchButton)
        watchButton.setTitle("Watch Now", for: .normal)
        watchButton.setTitleColor(.white, for: .normal)
        watchButton.backgroundColor    = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        watchButton.layer.cornerRadius = 12
        
        /*
         练习（4）
         - 左边 = 30
         - 右边 = 30
         - 底部 = 20
         - 高度 = 50
         */
        
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        watchButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30).isActive = true
        watchButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -30).isActive = true
        watchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        watchButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20).isActive = true
    }
    
    @objc func animateCard() {
        //点击事件
        if cardViewBottomConstraint.constant == 600{
            cardViewBottomConstraint.constant = -10
        }else{
            cardViewBottomConstraint.constant = 600
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func swipeCard() {
        //滑动事件
        cardViewBottomConstraint.constant = 600
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension UIView {
    
    func addDownSwipeListenner(target: AnyObject, action: Selector){
        //给view增加下滑事件
        let gr = UISwipeGestureRecognizer(target: target, action: action)
        gr.direction = .down
        self.isUserInteractionEnabled = true
        addGestureRecognizer(gr)
    }
}



let vc = MyViewController()
//vc.preferredContentSize = CGSize(width: 1024, height: 768)//iPad mini
vc.preferredContentSize = CGSize(width: 375, height: 812) //iPhone X
PlaygroundPage.current.liveView = vc






























/*:
 # 作业1： 学习其他控件的使用
 - UISegmentedControl
 - UISwitch
 - UIActivityIndicatorView
 - UITextField
 - UISlider
 - UIProgressView
 - other
 # 作业2： 按设计稿完成布局
 # 附加：
 创建一个类，然后创建一个元素为该类的数组。
 
 ## 类的属性：
 - myImage: UIImage
 - myName: String
 
 ## 类的方法：
 - 给图片和名字赋值
 */
