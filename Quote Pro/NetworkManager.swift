//
//  NetworkManager.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkManager: NSObject {

  private override init() { }
  
  static let sharedManager = NetworkManager()
  
  var quoteComponents = URLComponents(string: "https://api.forismatic.com")
  var imageComponents = URLComponents(string: "https://lorempixel.com/")
  
  func getQuote(language:String, completionHandler: @escaping (_ quoteLabel:String, _ authorLabel:String) -> Void)
  {
    let methodQuery = URLQueryItem(name: "method", value: "getQuote")
    let formatQuery = URLQueryItem(name: "format", value: "json")
    let rand = arc4random_uniform(899999) + 100000
    let keyQuery = URLQueryItem(name: "key", value: String(format: "%i", rand))
    let langQuery = URLQueryItem(name: "lang", value: language)
    
    quoteComponents?.path = "/api/1.0/"
    quoteComponents?.queryItems = [methodQuery, formatQuery, keyQuery, langQuery]
    
    var urlRequest = URLRequest(url: quoteComponents!.url!)
    urlRequest.httpMethod = "POST"
    
    performQuery(urlRequest: urlRequest) { (anyData) in
      let jsonData = anyData as! [String: AnyObject]
      let quoteLabel = jsonData["quoteText"] as! String
      let authorLabel = jsonData["quoteAuthor"] as! String
      
      completionHandler(quoteLabel, authorLabel)
    }
  }
  
  func getImage(width:Int, height:Int, category:String, completionHandler: @escaping (Data) -> Void)
  {
    imageComponents?.path = String(format:"/%li/%li/%@/", width, height, category)
    
    do {
      let imageData = try Data.init(contentsOf: imageComponents!.url!)
      completionHandler(imageData)
    } catch {
      print(error.localizedDescription)
    }
    
  }
  
  func performQuery(urlRequest:URLRequest, completionHandler:@escaping (Any) -> Void)
  {
    let configurations = URLSessionConfiguration.default
    let session = URLSession(configuration: configurations)
    let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
      if (error != nil)
      {
        print(error!.localizedDescription)
      }
      
      do {
        let responseData = try JSONSerialization.jsonObject(with: data!)
        completionHandler(responseData)
      } catch {
        print(error.localizedDescription)
      }
    }
    dataTask.resume()
  }
}
