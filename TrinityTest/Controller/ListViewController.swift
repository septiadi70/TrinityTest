//
//  ListViewController.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var searchBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .search,
                                     target: self,
                                     action: #selector(searchButtonTapped(_:)))
        return button
    }()
    
    lazy var addButtonBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add,
                                     target: self,
                                     action: #selector(addButtonTapped(_:)))
        return button
    }()
    
    struct K {
        static let cellId = "CellIdentifier"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configCollectionView()
    }

}

// MARK: - Helpers

extension ListViewController {
    private func configUI() {
        navigationItem.leftBarButtonItem = searchBarButton
        navigationItem.rightBarButtonItem = addButtonBarButton
        navigationItem.title = "Contacts"
        
        view.backgroundColor = .white
    }
    
    private func configCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ContactCollectionViewCell.self,
                                forCellWithReuseIdentifier: K.cellId)
        collectionView.register(UINib(nibName: "ContactCollectionViewCell", bundle: Bundle.main),
                                forCellWithReuseIdentifier: K.cellId)
    }
}

// MARK: - Actions

extension ListViewController {
    @objc func searchButtonTapped(_ sender: UIBarButtonItem) {}
    
    @objc func addButtonTapped(_ sender: UIBarButtonItem) {}
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellId, for: indexPath)
        guard let cell = aCell as? ContactCollectionViewCell else { return aCell }
        cell.imageView.backgroundColor = .orange
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: width)
    }
}
