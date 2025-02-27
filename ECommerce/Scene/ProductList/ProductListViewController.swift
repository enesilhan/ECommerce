//
//  ProductListViewController.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var gridButton: UIButton!
    
    private let viewModel = ProductListViewModel()
    private var isGridView = false {
        didSet {
            updateGridButtonIcon()
            collectionView.collectionViewLayout.invalidateLayout()
            collectionView.reloadData()
        }
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, ProductList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel()
        viewModel.fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UINib(nibName: "ListProductCell", bundle: nil), forCellWithReuseIdentifier: ListProductCell.reuseIdentifier)
        
        dataSource = UICollectionViewDiffableDataSource<Section, ProductList>(collectionView: collectionView) { (collectionView, indexPath, product) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListProductCell.reuseIdentifier, for: indexPath) as! ListProductCell
            cell.configure(with: product)
            return cell
        }
    }
    
    private func setupViewModel() {
        viewModel.onDataUpdated = { [weak self] products in
            self?.applySnapshot(with: products)
        }
        
        viewModel.onError = { errorMessage in
            // EmptyView Gösterimi Sağlanabilir.
        }
    }
    
    private func applySnapshot(with products: [ProductList]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductList>()
        snapshot.appendSections([.main])
        snapshot.appendItems(products, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = isGridView ? (collectionView.frame.width / 2 - spacing * 2) : (collectionView.frame.width - spacing * 2)
        let height: CGFloat = isGridView ? 200 : 120
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        return layout
    }
    
    private func updateGridButtonIcon() {
        let iconName = isGridView ? "square.grid.2x2.fill" : "list.bullet"
        gridButton.setImage(UIImage(systemName: iconName), for: .normal)
    }

    @IBAction func changeGridAction(_ sender: Any) {
        isGridView.toggle()
        
        UIView.animate(withDuration: 0.2) {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        guard let shareURL = viewModel.getShareLink(), !shareURL.isEmpty else { return }

        let activityVC = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        let selectedProduct = snapshot.itemIdentifiers[indexPath.item]
        
        guard let productId = selectedProduct.productID else { return }
        
        let detailVC = ProductDetailViewController(nibName: "ProductDetailViewController", bundle: nil)
        detailVC.productId = productId
        
        detailVC.onFavoriteUpdated = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let cell = collectionView.cellForItem(at: indexPath) as? ListProductCell {
                    cell.updateFavoriteButton()
                }
            }
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.height

            if offsetY > contentHeight - height * 1.5 {
                viewModel.fetchProducts()
            }
        }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        
        if isGridView {
            let width = (collectionView.frame.width / 2) - (spacing * 1.5)
            return CGSize(width: width, height: 243)
        } else {
            let width = collectionView.frame.width - (spacing * 2)
            return CGSize(width: width, height: 243)
        }
    }
}

extension ProductListViewController {
    enum Section {
        case main
    }
}
