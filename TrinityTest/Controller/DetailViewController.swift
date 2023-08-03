//
//  DetailViewController.swift
//  TrinityTest
//
//  Created by Andi Septiadi on 03/08/23.
//

import UIKit
import Combine

protocol DetailViewControllerDelegate: AnyObject {
    func detailViewControllerDidSave(_ controller: DetailViewController, contact: ContactModel)
}

class DetailViewController: UIViewController {
    var viewModel: DetailViewModel
    weak var delegate: DetailViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped(_:)))
        return button
    }()
    
    lazy var saveBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
        return button
    }()
    
    var bags = Set<AnyCancellable>()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        refreshForm()
        configBinding()
    }

}

// MARK: - Helpers

extension DetailViewController {
    private func configUI() {
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = saveBarButton
        
        view.backgroundColor = .white
        
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = true
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        birthTextField.delegate = self
    }
    
    private func refreshForm() {
        imageView.backgroundColor = .orange
        firstNameTextField.text = viewModel.contact?.firstName ?? ""
        lastNameTextField.text = viewModel.contact?.lastName ?? ""
        emailTextField.text = viewModel.contact?.email ?? ""
        birthTextField.text = viewModel.contact?.dob ?? ""
    }
    
    private func configBinding() {
        viewModel
            .$contact
            .receive(on: RunLoop.main)
            .sink { [weak self] contacts in
                self?.refreshForm()
            }
            .store(in: &bags)
    }
}

// MARK: - Actions

extension DetailViewController {
    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.save(firstName: firstNameTextField.text ?? "",
                       lastName: lastNameTextField.text ?? "",
                       email: emailTextField.text ?? "",
                       birth: birthTextField.text ?? "")
        if let contack = viewModel.contact {
            delegate?.detailViewControllerDidSave(self, contact: contack)
        }
    }
}

// MARK: - UITextFieldDelegate

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        }
        if textField == lastNameTextField {
            emailTextField.becomeFirstResponder()
        }
        if textField == emailTextField {
            birthTextField.becomeFirstResponder()
        }
        if textField == birthTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
