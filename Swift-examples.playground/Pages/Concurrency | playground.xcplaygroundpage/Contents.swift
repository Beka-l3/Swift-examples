import UIKit
import PlaygroundSupport

//let url = URL(staticString: "https://source.unsplash.com/random")

struct Movie {
//    let title: String
//    let year: Int
//    let rating: Float
//
//    let description: String
//    let actor: [String]
//
//    let director: String
//    let country: String
    
    let posterUrl: String
}

// MARK: - HIG
enum Design {}

extension Design {
    enum HIG {
        static let preferredContentSize = CGSize(width: 390, height: 844)
        static let tableCellHeight = preferredContentSize.width / 2
    }
}


final class NetworkService {
    
    static let shared: NetworkService = .init()
    
    
    func getRatedMovies() -> [Movie] {
        return [
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/products/54409_240x360_crop_center.progressive.jpg?v=1642690615"),
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/products/54362_2_240x360_crop_center.progressive.png.jpg?v=1634831916"),
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/products/mandalorian.12.11_240x360_crop_center.progressive.jpg?v=1607720303"),
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/products/wandavision.mp_240x360_crop_center.progressive.jpg?v=1614371756"),
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/products/mandalorian.53995_240x360_crop_center.progressive.jpg?v=1588361012"),
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/products/965a99756171f61611b6d6667b9f4004_240x360_crop_center.progressive.jpg?v=1573572622"),
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/files/migration_240x360_crop_center.progressive.jpg?v=1690896894"),
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/files/scan_af722215-7d13-4828-b20a-eea0ad296ea9_240x360_crop_center.progressive.jpg?v=1695238505"),
            .init(posterUrl: "https://www.movieposters.com/cdn/shop/files/napoleon_49dn2vko_240x360_crop_center.progressive.jpg?v=1691162741"),
            .init(posterUrl: "https://cdn.shopify.com/s/files/1/0057/3728/3618/products/interstellar3_a0a26c30-d23a-47e6-ba9f-3e5e95e89eef_500x749.jpg?v=1673036749"),
//            .init(posterUrl: ""),
        ]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratedMovies = NetworkService.shared.getRatedMovies()
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
        ratedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseIdentifier) as! MyCell
        cell.setData(movie: ratedMovies[indexPath.row])
//        cell.title = "\(indexPath.row)"
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
            tableView.topAnchor.constraint(equalTo: parent.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor),
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
    
    lazy var bgPoster: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var blurredDesk: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        blurEffectView.clipsToBounds = true
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    MARK: exposed func
    func setupViews(parent: UIView) {
//        parent.addSubview(titleLabel)
//        parent.addSubview(bgPoster)
//        bgPoster.frame = parent.bounds
        
        parent.backgroundColor = [UIColor.systemBlue, .systemPurple, .systemPink, .systemCyan, .systemMint].randomElement()!
        parent.addSubview(blurredDesk)
        
        NSLayoutConstraint.activate([
            blurredDesk.topAnchor.constraint(equalTo: parent.topAnchor),
            blurredDesk.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: .random(in: 0...100)),
            blurredDesk.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -.random(in: 0...100)),
            blurredDesk.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            
//            titleLabel.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
//            titleLabel.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
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