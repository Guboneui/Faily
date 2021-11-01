//
//  PostMakeEmoticonRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/11/01.
//

import Foundation
import Alamofire

class PostMakeEmoticonRepository {
    func postMakeEmoticon(_ parameters: PostMakeEmoticonRequest, onCompleted: @escaping(PostMakeEmoticonResponse) -> Void, onError: @escaping(String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        
        AF.request("\(ConstantURL.BASE_URL)/add/emoji", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: PostMakeEmoticonResponse.self){ response in
                switch response.result {
                case.success(let response):
                    print("PostMakeEmoticonRepository - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("PostMakeEmoticonRepository - repository - \(error)")
                }
                
            }
    }
}
