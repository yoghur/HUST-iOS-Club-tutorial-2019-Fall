//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    let titleLabel = UILabel()
    let videoTableView = UITableView()
    var CatVideo: [video] = []
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.view = view
        
        CatVideo = creatVideo()
        setupTitleLabel()
        setupTableView()
    }
    
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = "快 乐 吸 猫"
        titleLabel.textAlignment = .center
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 26)
        
        /*
         左边 0
         右边 0
         顶部 0
         高度 50
         */
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(videoTableView)
        videoTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        videoTableView.layer.cornerRadius = 10
        videoTableView.layer.masksToBounds = true
        videoTableView.rowHeight = 80//行高
        videoTableView.register(videoCell.self, forCellReuseIdentifier: "videoCell")//注册通用的 cell 样式
        
        /*
         下面这两句要求当前类，也就是 MyViewController 继承tableview的
            UITableViewDelegate
            UITableViewDataSource
         所以我们要用extension 继承
         */
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        /*
            分割线样式:
                单行线: singleLine
                无   : none
        */
        videoTableView.separatorStyle = .singleLine
        
        /*
         左边 0
         右边 0
         顶部 0
         底部 0
         */
        
        videoTableView.translatesAutoresizingMaskIntoConstraints = false
        videoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        videoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        videoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        videoTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    func creatVideo() -> [video]{
        var videos: [video] = []
        for index in 0 ... 12{
            let tempVideo = video()
            
            /*
                字符串操作，一定要掌握:
                拼接:     +
                转义：    \()
             */
            
            tempVideo.setupVideo(image: UIImage(named: "\(index)" + ".jpeg")!, title: "CAT \(index)", info: "This is a cute cat!")
            videos.append(tempVideo)
        }
        return videos
    }
}


class video{
    
    var coverImage: UIImage!
    var title: String = ""
    var info : String = ""
    
    func setupVideo(image: UIImage, title: String, info: String){
        self.coverImage = image
        self.title = title
        self.info = info
    }
}


class videoCell: UITableViewCell{
    
    var CoverImageView = UIImageView()
    var TitleLabel = UILabel()
    var InfoLabel = UILabel()
    
    //集成的 UITableViewCell 的初始化方法
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        CoverImageView.layer.cornerRadius = 10
        CoverImageView.layer.masksToBounds = true

        TitleLabel.textAlignment = .left
        TitleLabel.textColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
        InfoLabel.textAlignment = .left
        InfoLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)

        //将控件添加到cell的画布上
        contentView.addSubview(CoverImageView)
        contentView.addSubview(TitleLabel)
        contentView.addSubview(InfoLabel)
    }
    
    func setupConstraint(){
        
        contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        CoverImageView.translatesAutoresizingMaskIntoConstraints = false
        CoverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        CoverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        CoverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        CoverImageView.widthAnchor.constraint(equalTo: CoverImageView.heightAnchor, multiplier: 16.0/9.0).isActive = true
        
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.leadingAnchor.constraint(equalTo: CoverImageView.trailingAnchor, constant: 5).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        InfoLabel.translatesAutoresizingMaskIntoConstraints = false
        InfoLabel.leadingAnchor.constraint(equalTo: CoverImageView.trailingAnchor, constant: 5).isActive = true
        InfoLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 5).isActive = true
        InfoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        InfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
    }
    
    required init?(coder: NSCoder) {
        //创建失败时的解决方法
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(image: UIImage, title: String, info: String){
        //赋值
        CoverImageView.image = image
        TitleLabel.text = title
        InfoLabel.text = info
        //约束
        setupConstraint()
    }
}


extension MyViewController: UITableViewDelegate, UITableViewDataSource{
    
    // 这里面的函数全部为自动调用
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // tableview 初始化时查找 cell 的个数
        return CatVideo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell的样式
        let videoInCell = CatVideo[indexPath.row]//找到这个 cell 应该填充的数据
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell") as! videoCell//指定这个 cell 的样式
        cell.contentView.frame = CGRect(x: 0, y: 0, width: cell.contentView.frame.width, height: videoTableView.rowHeight)//重新裁剪 cell 的大小，默认高度为44，我们调整为80
        cell.setupCell(image: videoInCell.coverImage, title: videoInCell.title, info: videoInCell.info)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击cell之后的响应方法
        // indexPath 有 section(列) 和 row(行) 两个属性 我们一般用 row(行)
        print("\(CatVideo[indexPath.row].title)")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //cell是否可编辑
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //cell 右划的时候 执行函数
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        //自定义的delete函数
        let action = UIContextualAction(style: .destructive, title: "删除") { (action, view, nil) in
            self.CatVideo.remove(at: indexPath.row)//删掉数据
            self.videoTableView.deleteRows(at: [indexPath], with: .automatic)//删掉这一行
        }
        action.backgroundColor = .red
        return action
    }
}


// Present the view controller in the Live View window
let vc = MyViewController()
vc.preferredContentSize = CGSize(width: 375, height: 812)
PlaygroundPage.current.liveView = vc




























/*:
 # 课后作业： 学习 其他布局
 - UICollectionView
 - UIScorllView
 - others
 */
