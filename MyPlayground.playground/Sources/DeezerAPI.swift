//
//  DeezerAPI.swift
//  DixHeures
//
//  Created by Luc CASIMIR on 2/22/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import Foundation

public class DeezerAPI {
    public static let Shared = DeezerAPI()
    private let client = HttpClient()
    
    private init(){}
    
    public func requestUrl(String url: String, callback: @escaping ([Playlist])-> Void)
    {
        client.request(urlString: url, callback: callback)
    }
}
