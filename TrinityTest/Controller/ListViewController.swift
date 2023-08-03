//
//  ListViewController.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    var viewModel: ListViewModel
    
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
    
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .gray
        control.addTarget(self,
                          action: #selector(refreshControlDidChanged(_:)),
                          for: .valueChanged)
        return control
    }()
    
    var bags = Set<AnyCancellable>()
    
    struct K {
        static let cellId = "CellIdentifier"
    }
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ListViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configCollectionView()
        viewModel.loadContacts()
        configBinding()
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
        collectionView.alwaysBounceVertical = true
        collectionView.register(ContactCollectionViewCell.self,
                                forCellWithReuseIdentifier: K.cellId)
        collectionView.register(UINib(nibName: "ContactCollectionViewCell", bundle: Bundle.main),
                                forCellWithReuseIdentifier: K.cellId)
        collectionView.refreshControl = refreshControl
    }
    
    private func configBinding() {
        viewModel
            .$contacts
            .receive(on: RunLoop.main)
            .sink { [weak self] contacts in
                self?.collectionView.reloadData()
            }
            .store(in: &bags)
        
        viewModel
            .$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                if !isLoading {
                    self?.refreshControl.endRefreshing()
                }
            }
            .store(in: &bags)
    }
}

// MARK: - Actions

extension ListViewController {
    @objc func searchButtonTapped(_ sender: UIBarButtonItem) {}
    
    @objc func addButtonTapped(_ sender: UIBarButtonItem) {
        let viewController = Injection.provideDetailViewController(contact: nil)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func refreshControlDidChanged(_ sender: UIRefreshControl) {
        viewModel.loadContacts()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let aCell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellId, for: indexPath)
        guard let cell = aCell as? ContactCollectionViewCell else { return aCell }
        cell.config(ContactViewModel(contact: viewModel.contacts[indexPath.item]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contact = viewModel.contacts[indexPath.item]
        let viewController = Injection.provideDetailViewController(contact: contact)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ListViewController: DetailViewControllerDelegate {
    func detailViewControllerDidSave(_ controller: DetailViewController, contact: ContactModel) {
        navigationController?.popViewController(animated: true)
        viewModel.saveContact(contact)
    }
}
