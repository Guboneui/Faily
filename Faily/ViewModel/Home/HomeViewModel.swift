//
//  HomeViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/28.
//

import Foundation
import UIKit
import MKMagneticProgress
import MKColorPicker
import FSPagerView

class HomeViewModel {
    weak var homeView: HomeViewController?
    var homeInfo: HomeInfo? {
        didSet {
            homeView?.navTitleLabel.text = "\(homeInfo?.user_name ?? "")님의 가족"
            homeView?.totalProgress.setProgress(progress: CGFloat(homeInfo!.group_bonding * 0.01), animated: true)
            //homeView?.totalProgress.setProgress(progress: 1, animated: true)
            homeView?.percentLabel.text = "\(String(format: "%.2f", homeInfo?.group_bonding ?? 50))%"
            homeView?.scheduleTitleLabel.text = "\(homeInfo?.today_anniversary![Int.random(in: 0..<(homeInfo?.today_anniversary!.count ?? 1))].calendar_name ?? "특별한 추억을\n만들어 보세요.")"
            homeView?.memberProfileCollectionView.reloadData()
            
            homeView?.emotionPagerView.isScrollEnabled = false
            
            //["sick_big", "happy_big", "mumu_big", "sad_big", "angry_big"]
            //"화남", "아픔", "울음", "행복", "무덤덤"
            if homeInfo?.user_mood == "아픔" {
                homeView?.emotionPagerView.scrollToItem(at: 0, animated: false)
            } else if homeInfo?.user_mood == "행복" {
                homeView?.emotionPagerView.scrollToItem(at: 1, animated: false)
            } else if homeInfo?.user_mood == "무덤덤" {
                homeView?.emotionPagerView.scrollToItem(at: 2, animated: false)
            } else if homeInfo?.user_mood == "울음" {
                homeView?.emotionPagerView.scrollToItem(at: 3, animated: false)
            } else if homeInfo?.user_mood == "화남" {
                homeView?.emotionPagerView.scrollToItem(at: 4, animated: false)
            } else {
                print("정확하지 않은 기분 정보가 들어왔습니다.")
            }
            
           
            homeView?.emotionPagerView.isScrollEnabled = true
        }
    }
    let useService: HomeService = HomeService()
    
    func getHomeInfo() {
        useService.getHomeInfo(onCompleted: { [weak self] response in
            guard let self = self else {return}
            
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("홈화면 정보를 받아왔습니다. ")
                self.homeInfo = response.result!
                
                
                
                
            } else {
                print("error:\(code) message: \(message)")
                print("홈화면 정보를 받아오지 못했습니다.")
            }
            
        }, onError: {error in
            
            print("HomeViewModel - \(error)")
        })
    }
}
