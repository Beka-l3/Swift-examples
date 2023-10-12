import UIKit
import PlaygroundSupport

//PlaygroundPage.current.liveView = MyVC()
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
        return cell
    }
}


// MARK: - View components
final class MyVCViewComponents {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
//    MARK:  func
    func setupViews(parent: UIView) {
        
    }
    
}


// MARK: - Table view cell
final class MyCell: UITableViewCell {
    
    static let reuseIdentifier = "MyCellId"
    
    private enum Constants {
        static let height: CGFloat = Design.HIG.tableCellHeight
    }
    
    
//    MARK: UIKit
    private lazy var poster: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

//    MARK:  lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    MARK: exposed func
    func setData(movie: Movie) {
        
    }
    
    
//    MARK:  private func
    private func setupView() {
        
    }
}
