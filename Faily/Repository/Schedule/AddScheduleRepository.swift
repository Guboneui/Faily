//
//  AddScheduleRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/10/23.
//

import Foundation
import Alamofire

class AddScheduleRepository {
    func postAddSchedule(_ parameters: AddScheduleRequest, onCompleted: @escaping (AddScheduleResponse) -> Void, onError: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        
        AF.request("\(ConstantURL.BASE_URL)/addCalendar", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: AddScheduleResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("addshceduleRepository - postAddSchedule")
                    onCompleted(response)
                
                case .failure(let error):
                    onError("addScheduleRepository: \(error)")
                }
            }
    }
}
