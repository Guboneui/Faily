//
//  PostDeleteEmoticonRepository.swift
//  Faily
//
//  Created by 구본의 on 2021/11/02.
//

import Foundation
import Alamofire

class PostDeleteEmoticonRepository {
    func postDeleteEmoticon(_ parameters: PostDeleteEmoticonRequest, onCompleted: @escaping(PostDeleteEmoticonResponse) -> Void, onError: @escaping(String) -> Void) {
        let header: HTTPHeaders = [
            "jwt_token": UserDefaults.standard.string(forKey: UserDefaultKey.jwtToken)!
        ]
        
        AF.request("\(ConstantURL.BASE_URL)/delete/emoji", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: PostDeleteEmoticonResponse.self){ response in
                switch response.result {
                case.success(let response):
                    print("PostDeleteEmoticonRepository - repository")
                    onCompleted(response)
                case .failure(let error):
                    onError("PostDeleteEmoticonRepository - repository - \(error)")
                }
                
            }
    }
}
