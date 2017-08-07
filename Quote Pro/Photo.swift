//
//  Photo.swift
//  Quote Pro
//
//  Created by Errol Cheong on 2017-08-03.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit
import Realm

class Photo: RLMObject {
  
  dynamic var image = Data()
  dynamic var quote: Quote?

}
