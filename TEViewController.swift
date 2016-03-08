//
//  TEViewController.swift
//
//  Created by macsjh on 16/3/2.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit

class TEViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		if(self.navigationItem.leftBarButtonItem?.image == UIImage(named: "btn_back")){
			self.navigationItem.leftBarButtonItem?.target = self
			self.navigationItem.leftBarButtonItem?.action = "back:"
		}
	}
	
	func back(sender:UIBarButtonItem)
	{
		self.navigationController?.popViewControllerAnimated(true)
	}
}

