//
//  EditViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/09/03.
//

import UIKit

class EditViewController: BaseViewController {
    
    let backgroundView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let typeLabel = {
        let view = UILabel()
        view.textColor = .darkGray
        view.text = "dddddd"
        view.font = .systemFont(ofSize: 12, weight: .semibold)
        return view
    }()
    
    let textField = {
        let view = UITextField()
        view.backgroundColor = .white
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 14)
        view.borderStyle = .none
        view.clearButtonMode = .always
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(backgroundView)
        backgroundView.addSubview(typeLabel)
        backgroundView.addSubview(textField)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClicked))
        
    }
    
    @objc func doneButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(70)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.width.greaterThanOrEqualToSuperview().multipliedBy(0.06)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
    }
}

