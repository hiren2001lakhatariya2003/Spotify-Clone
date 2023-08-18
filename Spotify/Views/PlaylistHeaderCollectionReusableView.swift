//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 03/08/23.
//
import SDWebImage
import UIKit

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}


class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "PlaylistHeaderCollectionReusableView"
    
    
    weak var delegate : PlaylistHeaderCollectionReusableViewDelegate?
    
    
    private let namelabel : UILabel =
    {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionlabel : UILabel =
    {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let ownerlabel : UILabel =
    {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13, weight: .light)
        return label
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private let logoView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let playAllButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemGreen
        
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 27, weight: .regular))
        
        button.setImage(image,for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(namelabel)
        addSubview(descriptionlabel)
        addSubview(logoView)
        addSubview(ownerlabel)
        addSubview(playAllButton)
       
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapPlayAll(){
        delegate?.PlaylistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize : CGFloat = height/2.3
        imageView.frame = CGRect(x: (width-imageSize)/2,
                                 y: 20,
                                 width: imageSize,
                                 height: imageSize)
        
        namelabel.frame = CGRect(x: 10,
                                 y: imageView.bottom+10,
                                 width: width-20,
                                 height: 50)
        
        descriptionlabel.frame = CGRect(x: 10,
                                        y: namelabel.bottom,
                                 width:  width-20,
                                 height: 44)
        
        ownerlabel.frame = CGRect(x: logoView.right + 45,
                                  y: descriptionlabel.bottom,
                                 width:  width-20,
                                 height: 44)
        
        playAllButton.frame = CGRect(x: width-75,
                                     y: height-75,
                                     width: 60,
                                     height: 60)
        logoView.frame = CGRect(x: 10,
                                y: descriptionlabel.bottom + 10,
                                width: 27,
                                height: 27)
        
    }
    
    func configure(with viewModel: PlaylistHeaderViewViewModel){
        namelabel.text = viewModel.name
        ownerlabel.text = viewModel.ownerName
        descriptionlabel.text = viewModel.Descrption
        imageView.sd_setImage(with: viewModel.artworkURL,placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
}
