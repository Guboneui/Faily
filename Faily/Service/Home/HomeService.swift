//
//  HomeService.swift
//  Faily
//
//  Created by 구본의 on 2021/10/28.
//

import Foundation

class HomeService {
    let repository: HomeRepository = HomeRepository()
    func getHomeInfo(onCompleted: @escaping (HomeResponse) -> Void, onError: @escaping (String) -> Void) {
        repository.getHomeInfo(onCompleted: {response in
            let responseData = HomeResponse(isSuccess: response.isSuccess, code: response.code, message: response.message, result: response.result)
            onCompleted(responseData)
        }, onError: {error in
            onError(error)
        })
    }
}
