//
//  ViewController.swift
//  MovieApp
//
//  Created by User on 1/21/21.
//

import UIKit

class ViewController: UIViewController {
    var presenter:HomeViewToPresenterProtocol?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        customizeCell()
        title = "Movie App"
    }
}

//MARK:- Home Presenter To view Protocol
extension ViewController : HomePresenterToViewProtocol {
    func refreshTableViewCell(at index: IndexPath) {
        
    }
    
    func refreshTableView() {
        self.collectionView.reloadData()
    }
}

//MARK:- UISearchBar Delegate
extension ViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        presenter?.currentKeyWord = searchBar.text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

//MARK:- UICollection View Data source and Delegate
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDataSourcePrefetching,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (presenter?.movieList?.count ?? 0)-1 {
            presenter?.reachedBottomOftheScroll()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func customizeCell() {
        self.collectionView.register(UINib (nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")
        self.collectionView.collectionViewLayout = self.currentCollectionViewLayout()
    }
    
     func currentCollectionViewLayout () -> UICollectionViewFlowLayout {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        let collectionViewWidth = self.collectionView.frame.size.width
        layout.itemSize = CGSize(width: collectionViewWidth/2 - 20, height: 230)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        return layout;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as? HomeCollectionViewCell, let movie = presenter?.movieList?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.populateMovieData(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didClickMovies(for: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
              let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
              let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
              return CGSize(width: size, height: 230)
    }
    
}
