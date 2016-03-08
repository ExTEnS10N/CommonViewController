//
//  TEMessageBox.swift
//
//  Created by macsjh on 16/3/7.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit

class TEMessageBox{
	
	private static var _MessageBox:UIAlertController? = nil
	
	private static func presentMessageBox(parentVC: UIViewController){
		if(parentVC.tabBarController != nil){
			parentVC.tabBarController!.presentViewController(_MessageBox!, animated: true, completion: nil)
		}
		else if(parentVC.navigationController != nil){
			parentVC.navigationController!.presentViewController(_MessageBox!, animated: true, completion: nil)
		}
		else{
			parentVC.presentViewController(_MessageBox!, animated: true, completion: nil)
		}
	}
	
	///弹出OK消息对话框
	static func OKBox(title: String, message: String, parentVC: UIViewController, handler:(()->Void)? = nil)
	{
		if(_MessageBox == nil){
			_MessageBox = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
			
			// Action
			let okAction = UIAlertAction(title: "好吧", style: UIAlertActionStyle.Default)
				{(action: UIAlertAction!) -> Void in
					_MessageBox = nil
					if(handler != nil){handler!()}
			}
			_MessageBox!.addAction(okAction)
			
			//present
			presentMessageBox(parentVC)
		}
		else {print("Warning: Two more Message Boxes attempt to be presentted at the same time!")}
	}
	
	///	弹出输入框
	static func InputBox(title: String, placeHolders:[String], textFieldContent:[String]? = nil, parentVC: UIViewController, confirmHandler:([UITextField]) -> Void)
	{
		if textFieldContent != nil {
			guard placeHolders.count == textFieldContent!.count
				else {fatalError("Error: placeHolders.count != textFieldContent.count")}
		}
		if(_MessageBox == nil){
			_MessageBox = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
			
			// Action
			let confirmAction = UIAlertAction(title: "确认", style: .Default, handler: { (_:UIAlertAction) -> Void in
				confirmHandler(_MessageBox!.textFields!)
			})
			let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
			_MessageBox!.addAction(confirmAction)
			_MessageBox!.addAction(cancelAction)
			
			// textField
			for var i = 0; i < placeHolders.count; ++i{
				_MessageBox?.addTextFieldWithConfigurationHandler({ (textField:UITextField) -> Void in
					textField.placeholder = placeHolders[i]
					if textFieldContent != nil {textField.text = textFieldContent![i]}
				})
			}
			
			// present
			presentMessageBox(parentVC)
		}
		else {print("Warning: Two more Message Boxes attempt to be presentted at the same time!")}
	}
}

