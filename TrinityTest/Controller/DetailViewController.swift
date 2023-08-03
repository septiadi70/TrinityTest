//
//  DetailViewController.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped(_:)))
        return button
    }()
    
    lazy var saveBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

}

// MARK: - Helpers

extension DetailViewController {
    private func configUI() {
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = saveBarButton
        
        view.backgroundColor = .white
    }
}

// MARK: - Actions

extension DetailViewController {
    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
}
