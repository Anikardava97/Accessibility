//
//  NewsCollectionView.swift
//  AccessibleNews
//
//  Created by Ani's Mac on 27.12.23.
//

import SwiftUI

struct NewsCollectionView: UIViewRepresentable {
    // MARK: - Properties
    @EnvironmentObject var viewModel: NewsViewModel
    
    // MARK: - Methods
    func makeUIView(context: Context) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "NewsCell")
        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        uiView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - CollectionView DataSource
    class Coordinator: NSObject, UICollectionViewDataSource {
        var parent: NewsCollectionView
        
        init(_ collectionView: NewsCollectionView) {
            self.parent = collectionView
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            parent.viewModel.articles.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCollectionViewCell
            let article = parent.viewModel.articles[indexPath.row]
            cell.configure(with: article)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewsCollectionView.Coordinator: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + flowLayout.minimumInteritemSpacing
        
        let width = Int((collectionView.bounds.width - totalSpace) / 2)
        let height = 320
        
        return CGSize(width: width, height: height)
    }
}
