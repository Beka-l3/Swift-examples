import Foundation
import UIKit
import PlaygroundSupport

//let url = URL(staticString: "https://source.unsplash.com/random")

struct Movie {
    let title: String
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
        static let paddingSmall: CGFloat = 6
        static let padding: CGFloat = 16
        static let paddingMedium: CGFloat = 24
        static let paddingLarge: CGFloat = 36
        
        static let preferredContentSize = CGSize(width: 390, height: 844)
        static let tableCellHeight = preferredContentSize.width / 2 + paddingSmall
    }
}


final class NetworkService {
    
    static let shared: NetworkService = .init()
    
    
    func getRatedMovies() -> [Movie] {
        return [
            .init(title: "Arcane", posterUrl: "https://www.movieposters.com/cdn/shop/products/54409_240x360_crop_center.progressive.jpg?v=1642690615"),
            .init(title: "Loki", posterUrl: "https://www.movieposters.com/cdn/shop/products/54362_2_240x360_crop_center.progressive.png.jpg?v=1634831916"),
            .init(title: "Mandalorian", posterUrl: "https://www.movieposters.com/cdn/shop/products/mandalorian.12.11_240x360_crop_center.progressive.jpg?v=1607720303"),
            .init(title: "Wanda Vision", posterUrl: "https://www.movieposters.com/cdn/shop/products/wandavision.mp_240x360_crop_center.progressive.jpg?v=1614371756"),
            .init(title: "Mandalorian", posterUrl: "https://www.movieposters.com/cdn/shop/products/mandalorian.53995_240x360_crop_center.progressive.jpg?v=1588361012"),
            .init(title: "Flash", posterUrl: "https://www.movieposters.com/cdn/shop/products/965a99756171f61611b6d6667b9f4004_240x360_crop_center.progressive.jpg?v=1573572622"),
            .init(title: "Migration", posterUrl: "https://www.movieposters.com/cdn/shop/files/migration_240x360_crop_center.progressive.jpg?v=1690896894"),
            .init(title: "Five nights at Freddy's", posterUrl: "https://www.movieposters.com/cdn/shop/files/scan_af722215-7d13-4828-b20a-eea0ad296ea9_240x360_crop_center.progressive.jpg?v=1695238505"),
            .init(title: "Nopaleon", posterUrl: "https://www.movieposters.com/cdn/shop/files/napoleon_49dn2vko_240x360_crop_center.progressive.jpg?v=1691162741"),
            .init(title: "Interstellar", posterUrl: "https://cdn.shopify.com/s/files/1/0057/3728/3618/products/interstellar3_a0a26c30-d23a-47e6-ba9f-3e5e95e89eef_500x749.jpg?v=1673036749"),
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
        cell.setData(movie: ratedMovies[indexPath.row], indexRow: indexPath.row)
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
    func setData(movie: Movie, indexRow: Int) {
        viewComponents.checkConstraints(for: indexRow)
        
        viewComponents.bgPoster.setImage(with: movie.posterUrl, resolution: .x480)
        viewComponents.frontPoster.setImage(with: movie.posterUrl, resolution: .x480)
        viewComponents.titleLabel.text = movie.title
    }
    
    
//    MARK:  private func
    private func setupViews() {
        viewComponents.setupViews(parent: self)
    }
}

final class MyCellViewComponents {
    
    private enum Constants {
        static let height: CGFloat = Design.HIG.tableCellHeight
        static let width: CGFloat = Design.HIG.preferredContentSize.width
        
        static let blurredDeskWidth = height
        static let frontPosterWidth = width - blurredDeskWidth
        
        static let topShadowHeight = height * 0.15
    }
    
    private var leftAlignedConstraints: [NSLayoutConstraint] = []
    private var rightAlignedConstraints: [NSLayoutConstraint] = []
    
    lazy var bgPoster: CachedImageView = {
        let view = CachedImageView()
        view.contentMode = .scaleAspectFill
        view.setGradientColors([UIColor.black.cgColor, UIColor.systemYellow.cgColor, UIColor.black.cgColor])
        view.clipsToBounds = true
        return view
    }()
    
    lazy var blurredDesk: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        blurEffectView.layer.opacity = 0.95
        blurEffectView.clipsToBounds = true
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    lazy var frontPoster: CachedImageView = {
        let view = CachedImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.setGradientColors([UIColor.black.cgColor, UIColor.systemYellow.cgColor, UIColor.black.cgColor])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topShadow: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(white: .zero, alpha: 1).cgColor, UIColor(white: .zero, alpha: .zero).cgColor]
        layer.frame = .init(origin: .zero, size: .init(width: Constants.width, height: Constants.topShadowHeight))
        layer.zPosition = 10
        layer.opacity = 0.75
        return layer
    }()
    
//    MARK: exposed func
    func setupViews(parent: UIView) {
        parent.addSubview(bgPoster)
        parent.addSubview(blurredDesk)
        parent.addSubview(frontPoster)
        parent.addSubview(titleLabel)
        
        parent.layer.addSublayer(topShadow)
        
        NSLayoutConstraint.activate([
            blurredDesk.topAnchor.constraint(equalTo: parent.topAnchor),
            blurredDesk.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            blurredDesk.widthAnchor.constraint(equalToConstant: Constants.height),
            
            frontPoster.topAnchor.constraint(equalTo: parent.topAnchor),
            frontPoster.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: blurredDesk.leadingAnchor, constant: Design.HIG.paddingSmall),
            titleLabel.trailingAnchor.constraint(equalTo: blurredDesk.trailingAnchor, constant: -Design.HIG.paddingSmall),
            titleLabel.topAnchor.constraint(equalTo: blurredDesk.topAnchor, constant: Design.HIG.paddingLarge),
        ])
        
        bgPoster.frame = .init(origin: .zero, size: .init(width: Constants.width, height: Constants.height))
        
        leftAlignedConstraints.append(blurredDesk.leadingAnchor.constraint(equalTo: parent.leadingAnchor))
        leftAlignedConstraints.append(frontPoster.leadingAnchor.constraint(equalTo: blurredDesk.trailingAnchor))
        leftAlignedConstraints.append(frontPoster.trailingAnchor.constraint(equalTo: parent.trailingAnchor))
        
        rightAlignedConstraints.append(blurredDesk.trailingAnchor.constraint(equalTo: parent.trailingAnchor))
        rightAlignedConstraints.append(frontPoster.trailingAnchor.constraint(equalTo: blurredDesk.leadingAnchor))
        rightAlignedConstraints.append(frontPoster.leadingAnchor.constraint(equalTo: parent.leadingAnchor))
    }
    
    func checkConstraints(for indexRow: Int) {
        if indexRow.isMultiple(of: 2) {
            leftAlignedConstraints.forEach { $0.isActive = false }
            rightAlignedConstraints.forEach { $0.isActive = true }
        } else {
            rightAlignedConstraints.forEach { $0.isActive = false }
            leftAlignedConstraints.forEach { $0.isActive = true }
        }
    }
}


// MARK: - Extensions
extension String {
    @inline(__always) static let empty: String = ""
}


// MARK: - Image Service

public enum HTTPError: String, Error {
    case parametersNil = "Error: Parameters are nil"
    case headersNil = "Error: Headers are nil"
    case encodingFailed = "Error: Parameter encoding failed"
    case decodingFailed = "Error: Unable to decode the data"
    case missingURL = "Error: The URL is nil"
    case couldNotParse = "Error: Unable to parse the JSON response"
    case noData = "Error: The data from API is nil"
    case fragmentResponse = "Error  The API's response's body has fragments"
    case unwrappingError = "Error: Unable to unwrap the data"
    case dataTaskFailed = "Error: The data task object failed"
    case authenticationError = "Error: You must be authenticated"
    case badRequest = "Error: Bad request"
    case pageNotFound = "Error: Page/Route requested not found"
    case failed = "Error: Network request failed"
    case serverSideError = "Error: Server error"
    case missingURLComponents = "Error: The URL with components is nil"
}

protocol Cancellable {
    func cancel()
}

extension URLSessionDataTask: Cancellable {}

protocol ImageService: AnyObject {
    func fetchImage(
        with url: String,
        completion: @escaping (Result<UIImage, HTTPError>) -> Void
    ) -> Cancellable?
}


final class ImageServiceImp: ImageService {
    
    // MARK:  Properties
    
    private let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = .init(
            memoryCapacity: Constants.memoryCapacity,
            diskCapacity: Constants.diskCapacity
        )
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    static var shared: ImageServiceImp = .init()

    // MARK:  Lifecycle
    
    private init() {}
    
    // MARK:  Public
    
    @discardableResult
    func fetchImage(
        with url: String,
        completion: @escaping (Result<UIImage, HTTPError>) -> Void
    ) -> Cancellable? {
        if let image = UIImage(named: url) {
            completion(.success(image))
            return nil
        }
                
        guard let requestUrl = URL(string: url) else {
            completion(.failure(HTTPError.missingURL))
            return nil
        }

        
        let task = urlSession.dataTask(with: requestUrl) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async {
                    completion(.failure(HTTPError.noData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        task.resume()
        
        
        return task
    }
}


// MARK: - Cached Image
enum UserGalleryResolutions: CGFloat {
    case original, x480 = 480, x144 = 144
}

struct Service {
    static func checkAndCompressImage(_ image: UIImage, maxResolution: CGFloat, compressionQuality: CGFloat) -> UIImage? {
        let size = image.size
        let maxDimension = max(size.width, size.height)

        if maxDimension <= maxResolution {
            // Image doesn't exceed the maximum resolution, no need to compress
            return image
        }

        // Image exceeds the maximum resolution, compress it
        if let imageData = compressImage(image, maxResolution: maxResolution, compressionQuality: compressionQuality) {
            return UIImage(data: imageData)
        } else {
            return nil
        }
    }

    static func compressImage(_ image: UIImage, maxResolution: CGFloat, compressionQuality: CGFloat) -> Data? {
        let newSize = calculateNewSize(for: image.size, maxResolution: maxResolution)
        let scaledImage = scaleImage(image, toSize: newSize)

        return scaledImage.jpegData(compressionQuality: compressionQuality)
    }

    static func calculateNewSize(for size: CGSize, maxResolution: CGFloat) -> CGSize {
        let aspectRatio = size.width / size.height
        var newSize = CGSize(width: maxResolution, height: maxResolution)

        if aspectRatio > 1 {
            // Landscape image
            newSize.height = newSize.width / aspectRatio
        } else {
            // Portrait image or square image
            newSize.width = newSize.height * aspectRatio
        }

        return newSize
    }

    private static func scaleImage(_ image: UIImage, toSize newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage ?? image
    }
}

final class CachedImageView: UIImageView {
    // MARK:  Properties

    private let imageLoader = ImageServiceImp.shared
    private var isAnimationRunning = false
    private var lastRequest: Cancellable?

    var compressedImage: UIImage?
    var originalImage: UIImage?
    public var compressionQuality: CGFloat = 0.8

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [UIColor.lightGray.cgColor,
                                UIColor.white.cgColor,
                                UIColor.lightGray.cgColor]
        
        

        return gradientLayer
    }()

    var errorPlaceholder: UIImage?

    // MARK:  Lifecycle

    init() {
        super.init(frame: .zero)
        layer.addSublayer(gradientLayer)
        gradientLayer.isHidden = true
        setupImageView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }

    func setImage(with url: String, resolution: UserGalleryResolutions = .original) {
        startAnimation()

        if let lastRequest = lastRequest {
            lastRequest.cancel()
        }

        lastRequest = imageLoader.fetchImage(with: url) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let newImage):
                self.originalImage = newImage
                self.image = resolution == .original ?  self.originalImage : Service.checkAndCompressImage(newImage, maxResolution: resolution.rawValue, compressionQuality: compressionQuality)
                
//                self.stopAnimation()
            case .failure:
                if let errorPlaceholder = self.errorPlaceholder {
                    self.image = errorPlaceholder
                } else if let errorImage = UIImage(named: "error_load_image") {
                    self.image = errorImage
                }
            }
            self.stopAnimation()
        }
    }
    
    func setGradientColors(_ colors: [Any]) {
        gradientLayer.colors = colors
    }

//    MARK: - private func

    private func setupImageView() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }

    private func startAnimation() {
        guard !isAnimationRunning else {
            return
        }
        isAnimationRunning = true
        gradientLayer.isHidden = false

        let startLocations: [NSNumber] = [-1, -0.5, 0]
        let endLocations: [NSNumber] = [1, 1.5, 2]
        gradientLayer.locations = startLocations

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }

    private func stopAnimation() {
        isAnimationRunning = false
        gradientLayer.isHidden = true
        gradientLayer.removeAllAnimations()
    }
}



// MARK: - Nested types

extension ImageServiceImp {
    private enum Constants {
        static let memoryCapacity: Int = 1024 * 1024 * 100
        static let diskCapacity: Int = 1024 * 1024 * 100
    }
}




// MARK: - Playground

let vc = MyVC()
vc.preferredContentSize = Design.HIG.preferredContentSize

PlaygroundPage.current.liveView = vc
