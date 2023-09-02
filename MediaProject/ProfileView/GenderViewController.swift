//
//  GenderViewController.swift
//  MediaProject
//
//  Created by ChaewonMac on 2023/09/03.
//

import UIKit

class GenderViewController: BaseViewController {
    
    let list = Gender.allCases
    
    let label = {
        let view = UILabel()
        view.text = "This won't be part of your public profile"
        view.font = .systemFont(ofSize: 12, weight: .semibold)
        view.textColor = .darkGray
        return view
    }()
    
    let picker = UIPickerView()
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(label)
        view.addSubview(picker)
        
        title = "Gender"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonClicked))
        
        picker.delegate = self
        picker.dataSource = self
        
    }
    
    @objc func doneButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    override func setConstraints() {
        
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
        
        picker.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
    }
}

extension GenderViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        <#code#>
    }
    
    
}
