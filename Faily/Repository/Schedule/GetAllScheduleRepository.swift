//
//  GetAllScheduleRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/10/21.
//

import Foundation
import Alamofire

class GetAllScheduleRepository {
    func getAllSchedule(onCompleted: @escaping(GetScheduleResponse) -> Void, onError: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        
        AF.request("\(ConstantURL.BASE_URL)/Calendar", method: .get, headers: header)
            .validate()
            .responseDecodable(of: GetScheduleResponse.self) {response in
                switch response.result {
                case .success(let response):
                    print("GetAllSchedule - repository")
                    onCompleted(response)
                
                case .failure(let error):
                    onError("getallSchedule - repository: \(error)")
                }
            }
    }
}
