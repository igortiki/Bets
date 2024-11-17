//
//  BettingViewController.swift
//  Bets
//
//  Created by Admin on 11/16/24.
//

import UIKit

class BettingViewController: UIViewController {
    private var list: UICollectionView!
    private var activity: UIActivityIndicatorView!
    private var viewModel: BettingViewModelProtocol
    
    init(viewModel: BettingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "Odds"
        
        configureCollectonView()
        configureIndicatorView()
        loadData()
    }
    
    func loadData() {
        startAnimating()
        Task {
            await viewModel.loadData()
        }
    }
    
    private func configureCollectonView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        list = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        list.backgroundColor = .red
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
    }
    
    private func configureIndicatorView() {
        activity = UIActivityIndicatorView(style: .medium)
        activity.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activity)
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func startAnimating() {
        UIView.animate(withDuration: 1, animations: {
            self.list.isHidden = true
            self.activity.startAnimating()
        })
    }
    
    private func stopAnimating() {
        UIView.animate(withDuration: 1, animations: {
            self.list.isHidden = false
            self.activity.stopAnimating()
        })
    }
}

extension BettingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.item(at: indexPath)
        let cell = list.dequeueReusableCell(withReuseIdentifier: "cell_id", for: indexPath) as? UICollectionViewListCell
        var configuration = cell?.defaultContentConfiguration()
        configuration?.text = item.title
        cell?.contentConfiguration = configuration
        return cell ?? UICollectionViewListCell()
    }
}

extension BettingViewController: BettingViewModelDelegate {
    func reloadData() {
        self.stopAnimating()
        self.list.reloadData()
    }
}
