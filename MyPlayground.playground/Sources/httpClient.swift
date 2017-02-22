import Foundation

//fileprivate enum noValue{
//    ca
//}

public class HttpClient {

    public func requestTrack(_ tracks: String, callback: @escaping ([Track]) -> Void)
    {
        if let url = URL(string: tracks){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                if let d = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                           print(json)
                        }
                    }
                    catch let err {
                        print(err)
                    }
                }
            }
            task.resume()
        }
    }
    
    public func request(urlString add: String, callback: @escaping ([Playlist]) -> Void)
    {
        if let url = URL(string: add) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request)
            {
                data, response, error in
                if let d = data
                {
                    do
                    {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        {
                            print(json)
                            var res = [Playlist]()
                            if let data = json["data"] as? [NSDictionary] {
                                for elem in data {
                                    let title = elem["title"] as? String ?? "@NoValue"
                                    let tracklist = elem["tracklist"] as? String ?? "@NoValue"
                                    res.append(Playlist(title: title, tracklistUrl: tracklist))
                                }
                                callback(res)
                            }
                        }
                    }
                    catch let err {print(err)}
                }
            }
            task.resume()
        }
    }
}
