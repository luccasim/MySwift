import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let a = DeezerAPI.Shared

a.requestUrl(String: "https://api.deezer.com/user/5/playlists"){
    res in
    print("Ololol :")
    for elem in res
    {
        print(elem)
    }
}
print("Je continue la main thread")