import UIKit
import PlaygroundSupport


final class MyImageTableVC: UITableViewController {
    
    let imageUrls = [
        "https://images.unsplash.com/photo-1623491527126-8ccdf066feef?q=80&w=3072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1652650519133-16956d74279f?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1652648649332-7db46852da33?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1632733634218-a3f449d4af22?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1634735257780-f65fb715d626?q=80&w=3173&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1614866696055-b8588946b8f4?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1614866793299-784255396c47?q=80&w=3174&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MyImageTableViewCell.self, forCellReuseIdentifier: "hopa")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageUrls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hopa", for: indexPath)
        
        if let imageCell = cell as? MyImageTableViewCell {
            imageCell.imageUrl = URL(string: imageUrls[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}


final class MyImageTableViewCell: UITableViewCell {
    
    lazy var myImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageUrl: URL? {
        didSet {
            myImageView.image = nil
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setupView() {
        addSubview(myImageView)
        addSubview(spinner)
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: topAnchor),
            myImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            myImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 20),
            spinner.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func updateUI() {
        if let url = imageUrl {
            spinner.startAnimating()
            
            DispatchQueue.global(qos: .userInitiated).async {
                let contentsOfUrl = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    if url == self.imageUrl { /// we need to check if URLs are same
                        if let imageData = contentsOfUrl {
                            self.myImageView.image = UIImage(data: imageData)
                        }
                        
                        self.spinner.stopAnimating()
                    }
                    /// if not same, then that means we do not put image
                    /// that cell is went out of the screen
                    /// and new cell is using new URL
                    //
                    /// this is one of the aspect to consider
                    /// when working with concurrency
                }
            }
        }
    }
}


PlaygroundPage.current.liveView = MyImageTableVC()




