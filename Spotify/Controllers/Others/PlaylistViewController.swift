//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 07/07/23.
//

import Foundation
import UIKit

class PlaylistViewController : UIViewController{
    
    private let playlist : Playlist
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { index, _ -> NSCollectionLayoutSection in
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        //Vertical Group inside Horizontal Group
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(60)),
            subitem: item,
            count: 1)
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        //header Section
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1.0)),
                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                        alignment: .top)]
        //            section.orthogonalScrollingBehavior = .continuous
        return section
    })
    )
    
    init(playlist: Playlist)
    {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil) // when call this controller then first call this nibfile
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private var viewModels = [RecommendedTrackCellViewModel]()
    private var tracks = [AudioTrack]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = playlist.name
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.register(
            RecommendedTrackCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier
        )
        
        collectionView.register(
            PlaylistHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier
        )
        
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        APICaller.shared.getPlaylistDetails(for: playlist) { result in
            DispatchQueue.main.async {
                switch result
                {
                case.success(let model):
                    self.tracks = model.tracks.items.compactMap({ $0.track })
                    self.viewModels = model.tracks.items.compactMap({
                        RecommendedTrackCellViewModel(name: $0.track.name,
                                                      artistName: $0.track.artists.first?.name ?? "--",
                                                      artworkURL: URL(string: $0.track.album?.images.first?.url ?? ""))
                    })
                    self.collectionView.reloadData()
                    
                    break
                case.failure(let error):
                    
                    print(error.localizedDescription)
                    break
                }
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
    }
    //MARK: - Share URL of Playlist
    @objc private func didTapShare(){
        
        guard let url = URL(string: playlist.external_urls["spotify"] ?? "") else{
            return
        }
        
        let vc = UIActivityViewController(
            activityItems: ["Check out this cool playlist I found!",url],
            applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}

extension PlaylistViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath)
                as? RecommendedTrackCollectionViewCell else {
           return UICollectionViewCell()
       }
        cell.contentView.backgroundColor = UIColor(white: 0.1, alpha: 1)
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else
        {
            return UICollectionReusableView()
        }
        
        guard let header  = collectionView.dequeueReusableSupplementaryView(
            ofKind:  kind,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier,
            for: indexPath) as? PlaylistHeaderCollectionReusableView,
              kind == UICollectionView.elementKindSectionHeader else{
            return UICollectionReusableView()
        }
        
        let headerViewModel = PlaylistHeaderViewViewModel(
            name: playlist.name,
            ownerName: playlist.owner.display_name,
            Descrption: playlist.description,
            artworkURL: URL(string: playlist.images.first?.url ?? "") )
        
            header.configure(with: headerViewModel)
        header.delegate  = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let track = tracks[indexPath.row]
        PlaybackPresenter.shared.startPlayback(from: self, track: track)
    }
}

extension PlaylistViewController : PlaylistHeaderCollectionReusableViewDelegate {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        //Start play list play in queue
        PlaybackPresenter.shared.startPlayback(from: self, tracks: tracks)
    }
}
