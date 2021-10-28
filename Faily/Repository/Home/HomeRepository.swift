//
//  HomeRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/10/28.
//

import Foundation
import Alamofire

class HomeRepository {
    func getHomeInfo(onCompleted: @escaping (HomeResponse) -> Void, onError: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        AF.request("\(ConstantURL.BASE_URL)/Home", method: .get, headers: header)
            .validate()
            .responseDecodable(of: HomeResponse.self) {response in
                switch response.result {
                case .success(let response):
                    print("HomeRepository - func gethomeinfo")
                    onCompleted(response)
                
                case .failure(let error):
                    onError("HomeRepository - GetHomeInfo - \(error)")
                }
            }
    }
}
