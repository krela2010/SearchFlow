//
//  HttpServerStub.swift
//  SearchFlow
//
//  Created by 老刁 on 2020/12/14.
//

import Foundation
import Swifter

class HttpServerStubs {
    let server = HttpServer()
    func setUp() {
        let queue = DispatchQueue(label: "http server queue")
        queue.async {
            let server = HttpServer()

            //init mockdata
            do {
                let data = try JSONEncoder().encode(InResponse(inventories: inventories))
                let response = String(data:data, encoding:.utf8)!
                server["/Dyson"] = {_ in .ok(.text(response))}

            }catch {
                print(error)
            }
            
            
            //init server
            let semaphore = DispatchSemaphore(value: 0)
            do {
              try server.start(9080, forceIPv4: true)
              
              semaphore.wait()
            } catch {
              print("Server start error: \(error)")
              semaphore.signal()
            }
        }
        
       
    }
    
}
