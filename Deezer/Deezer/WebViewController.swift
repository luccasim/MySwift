//
//  ViewController.swift
//  Deezer
//
//  Created by luc Casimir on 16/02/2017.
//  Copyright © 2017 Owee. All rights reserved.
//

import WebKit
import UIKit

let APP_ID = 223684
let REDIR_URI = "http://oweeapp.e-monsite.com"
let SECRET = "7e56d33635c7ba5e66c5867dca9c4e0e"
let CONNECTION_URL = URL(string: "https://connect.deezer.com/oauth/auth.php?app_id=\(APP_ID)&redirect_uri=\(REDIR_URI)&perms=basic_access")!
let ACCESS_TOKEN_URL = "https://connect.deezer.com/oauth/access_token.php?app_id=\(APP_ID)&secret=\(SECRET)&code="

class WebViewController: UIViewController {

    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myRequest = URLRequest(url: CONNECTION_URL)
        myRequest.httpShouldHandleCookies = false
        self.view.backgroundColor = UIColor.init(patternImage: #imageLiteral(resourceName: "deezer"))
        webView.load(myRequest)
    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var dvc = segue.destination
        if let tabcon = dvc as? UITabBarController{
            dvc = (tabcon.viewControllers?[0])!
        }
        if let navcon = dvc as? UINavigationController {
            dvc = navcon.visibleViewController!
        }
        if let playlistvc = dvc as? PlaylistViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "playlistSegue":
                    if let api = sender as? APIDeezer {
                        playlistvc.apiDeezer = api
                    }
                default:
                    break
                }
            }
        }
    }
}

extension WebViewController : APIDeezerDelegate{
    func startApp(_ apiDeezer: APIDeezer, Data data: [Playlist]) {
        self.performSegue(withIdentifier: "playlistSegue", sender: apiDeezer)
    }
}

extension WebViewController : WKUIDelegate
{
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        let url = String(describing: webView.url!)
        if let code = url.range(of: "code=") {
            let str = url.substring(from: code.upperBound)
            if let acces_token = URL(string: ACCESS_TOKEN_URL + str) {
                webView.load(URLRequest(url: acces_token))
            }
        }
    }
}

extension WebViewController : WKNavigationDelegate
{
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let alerte = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alerte.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alerte, animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.innerHTML"){
            result, error in
            if let err = error {
                print("error : \(err)")
            }
            else {
                if let res = result{
                    if let str = res as? String {
                        let tab = str.components(separatedBy: "&")
                        for elem in tab {
                            if let rang = elem.range(of: "access_token="){
                                let access_token = elem.substring(from: rang.upperBound)
                                webView.isHidden = true
                                _ = APIDeezer(Delegate: self, Code: access_token)
                            }
                        }
                    }
                }
            }
        }
    }
}
