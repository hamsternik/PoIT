//
//  ViewController.swift
//  PoIT
//
//  Created by Nikita Khomitsevich on 2/17/17.
//  Copyright © 2017 Nikita Khomitsevich. All rights reserved.
//

import Cocoa

let PoITStorageData = "PoITStorageData"

class SignInViewController: NSViewController {

    var users: [Person]?
    
    // MARK: Properties
    
    @IBOutlet weak var authDescriptionTextView: NSScrollView!
    @IBOutlet weak var signInProgressIndicator: NSProgressIndicator!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInProgressIndicator.isHidden = true
    }

}

