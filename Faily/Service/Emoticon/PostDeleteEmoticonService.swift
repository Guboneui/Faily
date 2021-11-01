//
//  PostDeleteEmoticonService.swift
//  Faily
//
//  Created by 구본의 on 2021/11/02.
//

import Foundation

class PostDeleteEmoticonService {
    let repository: PostDeleteEmoticonRepository = PostDeleteEmoticonRepository()
    func postDeleteEmoticon(_ parameters: PostDeleteEmoticonRequest, onCompleted: @escaping(PostDeleteEmoticonResponse) -> Void, onError: @escaping(String) -> Void) {
        repository.postDeleteEmoticon(parameters, onCompleted: { response in
            let responseData = PostDeleteEmoticonResponse(isSuccess: response.isSuccess, code: response.code, message: response.message)
            onCompleted(responseData)
        }, onError: {error in
            onError(error)
        })
    }
}
