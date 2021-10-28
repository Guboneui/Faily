//
//  HomeViewModel.swift
//  Faily
//
//  Created by 구본의 on 2021/10/28.
//

import Foundation

class HomeViewModel {
    
    var homeInfo: [HomeInfo] = []
    let useService: HomeService = HomeService()
    weak var homeView: HomeViewController?
    func getHomeInfo() {
        useService.getHomeInfo(onCompleted: { [weak self] response in
            guard let self = self else {return}
            
            let message = response.message
            let code = response.code
            
            if response.isSuccess == true {
                print("홈화면 정보를 받아왔습니다. ")
                self.homeInfo = response.result ?? []
                
                
                
                
            } else {
                print("error:\(code) message: \(message)")
                print("홈화면 정보를 받아오지 못했습니다.")
            }
            
        }, onError: {error in
            
            print("HomeViewModel - \(error)")
        })
    }
}
