//
//  ProductListViewController.swift
//  ECommerce
//
//  Created by Enes İlhan on 27.02.2025.
//

import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var gridButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func changeGridAction(_ sender: Any) {
    }
    
    @IBAction func shareAction(_ sender: Any) {
    }
}
