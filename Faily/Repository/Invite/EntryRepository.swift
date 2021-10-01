//
//  EntryRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/10/02.
//

import Foundation
import Alamofire

class EntryRepository {
    func postEntryChat(_ parameters: EntryRequest, onCompleted: @escaping (EntryResponse) -> Void, onError: @escaping (String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        AF.request("\(ConstantURL.BASE_URL)/EntryChat", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: EntryResponse.self) { response in
                switch response.result{
                case .success(let response):
                    print("postEntryChat - repository")
                    onCompleted(response)
                
                case .failure(let error):
                    onError("postEntryChat - repository: \(error)")
                }
            }
    }
}
