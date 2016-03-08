//
//  TETableViewController.swift
//
//  Created by macsjh on 16/3/6.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit

class TETableViewController: UITableViewController {

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
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let cell = tableView.cellForRowAtIndexPath(indexPath)
		if (cell?.accessoryType != .DetailDisclosureButton
		 && cell?.accessoryType != .DisclosureIndicator){
			cell?.setSelected(false, animated: true)
		}
	}
}
