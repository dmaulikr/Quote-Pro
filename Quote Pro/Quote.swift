//
//  Quote.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit
import RealmSwift

class Quote: Object {
  
  dynamic var author = ""
  dynamic var quote = ""
  dynamic var photo: Photo?
}
