//
//  OnBoardingViewController.swift
//  Faily
//
//  Created by 구본의 on 2021/09/15.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var onBoardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: PinkMainButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setCollectionView()
        setPageControl()
    }
    
    func configUI() {
        startButton.isHidden = true
    }
    
    func setCollectionView() {
        onBoardingCollectionView.delegate = self
        onBoardingCollectionView.dataSource = self
        onBoardingCollectionView.register(UINib(nibName: "OnBoardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OnBoardingCollectionViewCell")
        onBoardingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        onBoardingCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: view.frame.width, height: onBoardingCollectionView.frame.height)
        flowLayout.scrollDirection = .horizontal
        onBoardingCollectionView.collectionViewLayout = flowLayout
    }
    
    func setPageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = UIColor.FailyColor.mainPinkColor
        pageControl.pageIndicatorTintColor = UIColor.FailyColor.grayscale_5
        pageControl.backgroundColor = UIColor.clear
    }

}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCollectionViewCell", for: indexPath) as! OnBoardingCollectionViewCell
        if(indexPath.item == 0){
            print("page: 1")
        }else if(indexPath.item == 1){
            print("page: 2")
        }else if(indexPath.item == 2){
            print("page: 3")
        } else {
            print("page: 4")
        }
        cell.configure(index: indexPath.item)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        if pageControl.currentPage == 3 {
            startButton.isHidden = false
        } else {
            startButton.isHidden = true
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 50, height: 10)
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }



}
