//
//  ViewController.swift
//  HepsiburadaCase
//
//  Created by Kursat on 19.10.2021.
//

import UIKit
import Alamofire

class GridViewController: UIViewController, UISearchBarDelegate {
    let searchBar = UISearchBar()
    let segmentedControl = UISegmentedControl(items: ["Movies", "Music", "Ebook", "Podcast"])
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        flowLayout.minimumLineSpacing = 15.0
        flowLayout.minimumInteritemSpacing = 15.0
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    var workItem: DispatchWorkItem?
    var items: [Result] = []
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var hasMore = false
    var loading = false
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(segmentedControl)
        view.addSubview(activityIndicator)
        
        view.backgroundColor = UIColor.systemGray4
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: CollectionViewCell.self)
        collectionView.register(cellType: LoadingCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        searchBar.placeholder = "SEARCH"
        searchBar.sizeToFit()
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .white
        navigationItem.titleView = searchBar
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        segmentedControl.selectedSegmentTintColor = .systemOrange
        segmentedControl.tintColor = .black
        segmentedControl.backgroundColor = .white
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func fetch(text: String) {
        let trimmedText =  text.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "+")
        let path: URL
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            path = iTunesRouter.movies(word: trimmedText, offset: itemsPerPage * page).path
        case 1:
            path = iTunesRouter.music(word: trimmedText, offset: itemsPerPage * page).path
        case 2:
            path = iTunesRouter.ebook(word: trimmedText, offset: itemsPerPage * page).path
        case 3:
            path = iTunesRouter.podcast(word: trimmedText, offset: itemsPerPage * page).path
        default:
            fatalError("Cannot happen")
        }
        activityIndicator.startAnimating()
        loading = true
        AF.request(path).responseData { [weak self] (data) in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.loading = false
            switch data.result {
            case let .success(rawResponse):
                do {
                    let response = try JSONDecoder().decode(Response.self, from: rawResponse)
                    self.items += response.results
                    self.hasMore = response.resultCount == itemsPerPage
                    if self.hasMore {
                        self.page += 1
                    }
                    self.collectionView.reloadData()
                } catch {
                    print("Error: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else { return }
        workItem?.cancel()
        workItem = DispatchWorkItem(block: {
            self.resetData()
            self.fetch(text: searchText)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem!)
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        if searchBar.text?.count ?? 0 <= 2 { return }
        resetData()
        fetch(text: searchBar.text!)
    }
    
    func resetData() {
        items = []
        hasMore = false
        page = 0
        collectionView.reloadData()
    }
}

extension GridViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if hasMore {
            return items.count + 1
        }
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == items.count && hasMore {
            let cell: LoadingCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.prepare(with: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ItemDetailViewController(item: items[indexPath.item]), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is LoadingCollectionViewCell && !loading {
            fetch(text: searchBar.text!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        if indexPath.item == items.count {
            return CGSize(width: collectionView.frame.width, height: 100.0)
        } else {
            return CGSize(width: (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing) / 2.0, height: 270.0)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: view)
        if velocity.y < -5.0 {
            searchBar.resignFirstResponder()
        }
    }
}
