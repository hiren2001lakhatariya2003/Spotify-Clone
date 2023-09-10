//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 11/08/23.
//

// backward.end.fill
// forward.end.fill
// pause.circle.fill

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView)
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
    func playerControlsViewDidTapHeartButton(_ playerControlsView: PlayerControlsView)
}

struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView {

    private var isPlaying = true
    private var isFevorite = false

    weak var delegate: PlayerControlsViewDelegate?

    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "This Is My Song"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let HeartButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Drake (feat. Some Other Artist)"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()

    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(HeartButton)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(playPauseButton)

        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        HeartButton.addTarget(self, action: #selector(didTapHeart), for: .touchUpInside)
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
    }

    @objc private func didTapBack() {
        delegate?.playerControlsViewDidTapBackwardsButton(self)
    }

    @objc private func didTapNext() {
        delegate?.playerControlsViewDidTapForwardButton(self)
    }

    @objc private func didTapPlayPause() {
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPauseButton(self)

        // Update icon
        let pause = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 70, weight: .regular))
        let play = UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 70, weight: .regular))

        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    @objc private func didTapHeart() {
        delegate?.playerControlsViewDidTapHeartButton(self)

        // Update icon
        if HeartButton.currentImage == UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        {
            HeartButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        }
       else
        {
           HeartButton.setImage(UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
       }
       
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: width-40,
            height: 50)
        
        HeartButton.frame = CGRect(x: nameLabel.right, y: nameLabel.top+10, width: 30, height: 28)
        
        subtitleLabel.frame = CGRect(
            x: 0,
            y: nameLabel.bottom+5,
            width: width-20,
            height: 20)

        volumeSlider.frame = CGRect(
            x: 10,
            y: subtitleLabel.bottom+10,
            width: width-20,
            height: 44)

        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(x: (width - buttonSize - 5)/2, y: volumeSlider.bottom + 30, width: 70, height: 70)
        backButton.frame = CGRect(x: playPauseButton.left-40-buttonSize, y: playPauseButton.top+4, width: buttonSize, height: buttonSize)
        nextButton.frame = CGRect(x: playPauseButton.right+40, y: playPauseButton.top+4, width: buttonSize, height: buttonSize)
    }

    func configure(with viewModel: PlayerControlsViewViewModel) {
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
