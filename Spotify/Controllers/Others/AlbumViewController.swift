//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 02/08/23.
//

import UIKit

class AlbumViewController: UIViewController {
    
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
    
    private var viewModels = [AlbumCollectionViewCellViewModel]()
    private var tracks = [AudioTrack]()
    private let album : Album
    
    init(album: Album)
    {
        self.album = album
        super.init(nibName: nil, bundle: nil) // when call this controller then first call this nibfile
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        
        
        view.addSubview(collectionView)
        collectionView.register(
            AlbumTrackCollectionViewCell.self,
            forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.identifier
        )
        
        collectionView.register(
            PlaylistHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier
        )
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        APICaller.shared.getAlbumDetails(for: album) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.tracks = model.tracks.items
                    self?.viewModels = model.tracks.items.compactMap({
                        AlbumCollectionViewCellViewModel(
                            name: $0.name,
                            artistName: $0.artists.first?.name ?? "-"
                        )
                    })
                    self?.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Share URL of Album
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension AlbumViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumTrackCollectionViewCell.identifier,
            for: indexPath
        ) as? AlbumTrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier,
            for: indexPath
        ) as? PlaylistHeaderCollectionReusableView,
              
                kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        
        let headerViewModel = PlaylistHeaderViewViewModel(
            name: album.name,
            ownerName: album.artists.first?.name,
            Descrption: "Release Date: \(String.formattedDate(string: album.release_date))",
            artworkURL: URL(string: album.images.first?.url ?? "")
        )
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        var track = tracks[indexPath.row]
        track.album = self.album
        PlaybackPresenter.shared.startPlayback(from: self, track: track)
    }
}

extension AlbumViewController: PlaylistHeaderCollectionReusableViewDelegate {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        let tracksWithAlbum: [AudioTrack] = tracks.compactMap({
            var track = $0
            track.album = self.album
            return track
        })
        PlaybackPresenter.shared.startPlayback(from: self, tracks: tracksWithAlbum)
    }
    
    
}