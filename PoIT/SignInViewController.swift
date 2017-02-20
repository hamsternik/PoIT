//
//  ViewController.swift
//  PoIT
//
//  Created by Nikita Khomitsevich on 2/17/17.
//  Copyright © 2017 Nikita Khomitsevich. All rights reserved.
//

import Cocoa


class SignInViewController: NSViewController {

    // MARK: Properties
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    @IBOutlet weak var authDescriptionTextView: NSScrollView!
    
    @IBOutlet weak var signInButton: NSButton!
    
    @IBOutlet weak var signInProgressIndicator: NSProgressIndicator!
    
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInProgressIndicator.isHidden = true
        
    }

}

