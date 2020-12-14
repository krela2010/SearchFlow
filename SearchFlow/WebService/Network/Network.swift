//
//  Network.swift
//  SearchFlow
//
//  Created by 老刁 on 2020/12/14.
//

import Foundation
import Alamofire

func requestTest(_ param:String, completion: @escaping (DataResponse<Any>)->Void) {
    guard let url = URL(string: "\(SF.baseURL)\(param)") else {
       
       return
     }

    Alamofire.request(url, method: .post).responseJSON{response in
        print("response+\(response.debugDescription)")
        completion(response)
        
    }
}
