import UIKit
import BetsCore

class ViewController: UIViewController, UICollectionViewDataSource {
    
    private var list: UICollectionView!
    private var activity: UIActivityIndicatorView!
    
    private let repository = BetRepository(service: RemoteBetService.instance)
    private var items: [Bet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Odds"
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        list = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        list.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "cell_id")
        
        list.dataSource = self
        list.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(list)
        list.isHidden = true
        NSLayoutConstraint.activate([
            list.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            list.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            list.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            list.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        activity = UIActivityIndicatorView(style: .medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activity)
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        UIView.animate(withDuration: 1, animations: {
            self.list.isHidden = true
            self.activity.startAnimating()
        }) { _ in
            Task {
                do {
                    self.items = try await self.repository.updateOdds()
                    await MainActor.run {
                        self.list.reloadData()
                        UIView.animate(withDuration: 1, animations: {
                            self.list.isHidden = false
                            self.activity.stopAnimating()
                        })
                    }
                } catch {
                    print("Error fetching items.")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = list.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath) as? UICollectionViewListCell
        var configuration = cell?.defaultContentConfiguration()
        configuration?.text = item.name
        cell?.contentConfiguration = configuration
        return cell ?? UICollectionViewListCell()
    }
}
