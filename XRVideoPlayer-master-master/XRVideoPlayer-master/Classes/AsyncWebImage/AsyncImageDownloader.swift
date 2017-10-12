//
//  AsyncImageDownloader.swift
//  XRVideoPlayer-master
//
//  Created by xuran on 16/4/27.
//  Copyright © 2016年 黯丶野火. All rights reserved.
//

/**
 *  AsyncImageDownloader
 *
 *  @brief  图片资源下载
 *  @by     黯丶野火
 **/

import Foundation
import UIKit

class AsyncImageDownloader: NSObject {
    
    fileprivate static var __once: () = {
        if Inner.imageDownloader == nil {
            Inner.imageDownloader = AsyncImageDownloader()
        }
    }()
    
    fileprivate lazy var URLSession: Foundation.URLSession = {
        let session: Foundation.URLSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        return session
    }()
    
    fileprivate lazy var operationQueue: OperationQueue = OperationQueue()
    
    deinit {
        operationQueue.cancelAllOperations()
    }
    
    fileprivate override init() {
        super.init()
        
        operationQueue.maxConcurrentOperationCount = 1
        
    }
    
    fileprivate struct Inner {
        static var onceToken: Int = 0
        static var imageDownloader: AsyncImageDownloader?
    }
    
    static func sharedImageDownloader() -> AsyncImageDownloader {
        
        _ = AsyncImageDownloader.__once
        
        return Inner.imageDownloader!
    }
    
    func downloadImageWithURL(_ URLString: String?, complationHandle: @escaping ((_ image: UIImage?) -> Void)) {
        
        if let urlStr = URLString {
            
            operationQueue.addOperation({ [weak self]() -> Void in
                if let weakSelf = self {
                    
                    let request = URLRequest(url: URL(string: urlStr)!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15.0)
                    
                    let dataTask = weakSelf.URLSession.dataTask(with: request, completionHandler: { (data, response, error) in
                        
                        if let imageData = data {
                            let image = UIImage.init(data: imageData)
                            
                            DispatchQueue.main.async(execute: {
                                complationHandle(image)
                            })
                        }
                    })
                    
                    dataTask.resume()
                }
            })
        }
    }
    
}