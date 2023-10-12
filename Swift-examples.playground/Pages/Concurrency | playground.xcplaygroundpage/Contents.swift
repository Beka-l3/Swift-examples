import UIKit
import PlaygroundSupport

//let url = URL(staticString: "https://source.unsplash.com/random")

struct Movie {
    let title: String
    let year: Int
    let rating: Float
    
    let description: String
    let actor: [String]
    
    let director: String
    let country: String
}

// MARK: - HIG
enum Design {}

extension Design {
    enum HIG {
        static let preferredContentSize = CGSize(width: 390, height: 844)
        static let tableCellHeight = preferredContentSize.width / 2
    }
}

// MARK: - View controller
final class MyVC: UIViewController {
    
    private let viewComponents: MyVCViewComponents = .init()
    private var ratedMovies: [Movie] = []
    
    
//    MARK:  lifeCycle
    override func loadView() {
        let view = UIView()
        self.view = view
        
        setupViews()
    }
    
    
//    MARK:  exposed func
    
    
//    MARK:  private func
    private func setupViews() {
        viewComponents.setupViews(parent: view)
        
        viewComponents.tableView.delegate = self
        viewComponents.tableView.dataSource = self
    }
}

extension MyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Design.HIG.tableCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        ratedMovies.count
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseIdentifier) as! MyCell
//        cell.setData(movie: ratedMovies[indexPath.row])
        cell.title = "\(indexPath.row)"
        return cell
    }
}


// MARK: - View components
final class MyVCViewComponents {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
//    MARK:  func
    func setupViews(parent: UIView) {
        parent.backgroundColor = .systemPurple
        parent.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
}


// MARK: - Table view cell
final class MyCell: UITableViewCell {
    
    static let reuseIdentifier = "MyCellId"
    
    private enum Constants {
        static let height: CGFloat = Design.HIG.tableCellHeight
    }
    
    private let viewComponents: MyCellViewComponents = .init()
    
    var title: String {
        get { viewComponents.titleLabel.text ?? .empty }
        set { viewComponents.titleLabel.text = newValue }
    }
    

//    MARK:  lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    
//    MARK: exposed func
    func setData(movie: Movie) {
        
    }
    
    
//    MARK:  private func
    private func setupViews() {
        viewComponents.setupViews(parent: self)
    }
}

final class MyCellViewComponents {
    
    lazy var poster: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    MARK: exposed func
    func setupViews(parent: UIView) {
        parent.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
        ])
    }
}


// MARK: - Extensions
extension String {
    @inline(__always) static let empty: String = ""
}




// MARK: - Playground
let vc = MyVC()
vc.preferredContentSize = Design.HIG.preferredContentSize

PlaygroundPage.current.liveView = vc
