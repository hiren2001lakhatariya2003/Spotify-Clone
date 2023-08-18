//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Hiren Lakhatariya on 25/06/23.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistVC = LibraryPlaylistsViewController()
    private let albumVC = LibraryAlbumsViewController()
    
    private let scrollview : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let toggleView = LibraryToggleView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(toggleView)
        toggleView.delegate = self
        scrollview.delegate = self
        view.addSubview(scrollview)
        scrollview.contentSize = CGSize(width: view.width*2, height: scrollview.height)
        addChildren()
        updateBarButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollview.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top+55,
            width: view.width,
            height: view.height-view.safeAreaInsets.bottom-55)
        
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 200, height: 55 )
    }
    
    private func updateBarButtons(){
        switch toggleView.state{
        case.playlist:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        case.album:
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func didTapAdd(){
        playlistVC.showCreatePlaylistAlert()
    }
    
    private func addChildren(){
        addChild(playlistVC)
        scrollview.addSubview(playlistVC.view)
        playlistVC.view.frame = CGRect(x: 0, y: 0, width: scrollview.width, height: scrollview.height)
        playlistVC.didMove(toParent: self)
        
        addChild(albumVC)
        scrollview.addSubview(albumVC.view)
        albumVC.view.frame = CGRect(x: view.width, y: 0, width: scrollview.width, height: scrollview.height)
        albumVC.didMove(toParent: self)
    }

}

extension LibraryViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width - 100) {
            toggleView.update(for: .album)
            updateBarButtons()
        }
        else {
            toggleView.update(for: .playlist)
            updateBarButtons()
        }
    }
}

extension LibraryViewController : LibraryToggleViewDelegate {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
        scrollview.setContentOffset(.zero, animated: true)
        updateBarButtons()
    }
    
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
        scrollview.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        updateBarButtons()
    }
}

