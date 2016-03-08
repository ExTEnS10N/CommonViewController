//
//  TEMessageBox.swift
//
//  Created by macsjh on 16/3/7.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit

class TEMessageBox{
	
	private static var _MessageBox:UIAlertController? = nil
	///弹出OK消息对话框
	static func OKBox(title: String, message: String, parentViewController: UIViewController, handler:(()->Void)? = nil)
	{
		if(_MessageBox == nil){
			_MessageBox = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
			let okAction = UIAlertAction(title: "好吧", style: UIAlertActionStyle.Default)
			{(action: UIAlertAction!) -> Void in
				_MessageBox = nil
				if(handler != nil){handler!()}
			}
			_MessageBox!.addAction(okAction)
			
			if(parentViewController.tabBarController != nil){
				parentViewController.tabBarController!.presentViewController(_MessageBox!, animated: true, completion: nil)
			}
			else if(parentViewController.navigationController != nil){
				parentViewController.navigationController!.presentViewController(_MessageBox!, animated: true, completion: nil)
			}
			else{
				parentViewController.presentViewController(_MessageBox!, animated: true, completion: nil)
			}
		}
		else {print("Warning: Two more Message Boxes attempt to be presentted at the same time!")}
	}
}

