//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 01/08/23.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let PlaylistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(PlaylistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        creatorNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height-30,
            width: contentView.width-6,
            height: 30
        )
        PlaylistNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height-60,
            width: contentView.width-6,
            height: 44
        )
        
        let imageSize = contentView.height-70
        playlistCoverImageView.frame = CGRect(
            x: (contentView.width - imageSize)/2,
            y: 3,
            width: imageSize,
            height: imageSize)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        PlaylistNameLabel.text = nil
        playlistCoverImageView.image = nil
        creatorNameLabel.text = nil
        
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        PlaylistNameLabel.text = viewModel.name
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL,completed: nil)
        creatorNameLabel.text = viewModel.creatorName
    }
    
}
