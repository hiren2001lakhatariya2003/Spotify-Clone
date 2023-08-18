//
//  ActionLabelView.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 15/08/23.
//

import UIKit

struct ActionLabelViewViewModel{
    let text: String
    let actionTitle: String
}

protocol ActionLabelViewDelegate: AnyObject{
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView)
}

class ActionLabelView: UIView{
    
    
    
    weak var delegate : ActionLabelViewDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        isHidden = true
        label.textColor = .secondaryLabel
        addSubview(label)
        addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
    }
    
    @objc func didTapButton(){
        delegate?.actionLabelViewDidTapButton(self)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame  =  CGRect(x: 0, y: height-50, width: width, height: 30)
        label.frame = CGRect(x: 0, y: 0, width: width, height: height-55)
    }
    
    func configure (with viewModel: ActionLabelViewViewModel) {
        label.text = viewModel.text
        button.setTitle(viewModel.actionTitle, for: .normal)
        
    }
}
