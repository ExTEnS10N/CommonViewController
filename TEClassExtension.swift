//
//  TEClassExtension.swift
//
//  Created by macsjh on 16/3/7.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit

extension NSURL{
	
	///	检查url是否合法，自动检测协议，若无则添加https://
	///
	///	- parameter StringToBeCheck:	 需要检查的字符串
	///
	///	- returns: 如果字符串不合法返回nil
	convenience init?(StringToBeCheck:String){
		guard StringToBeCheck.characters.count > 0 else {return nil}
		var urlString = ""
		if(StringToBeCheck.rangeOfString(":") == nil){
			urlString = "https://" + StringToBeCheck
		}
		else {urlString = StringToBeCheck}
		self.init(string: urlString)
		if !UIApplication.sharedApplication().canOpenURL(self){
			return nil
		}
	}
}

extension String
{
	func subString(fromIndex:Int, length:Int) -> String
	{
		let temp = NSString(string: self)
		let tempFrom = NSString(string: temp.substringFromIndex(fromIndex))
		return tempFrom.substringToIndex(length)
	}
	
	///返回给定字符串在本串中的位置，不存在返回-1
	func indexOf(string: String) -> Int
	{
		let range = NSString(string: self).rangeOfString(string)
		if(range.length < 1)
		{
			return -1
		}
		return range.location
	}
	
	var intValue:Int?
		{
		get{
			return NSNumberFormatter().numberFromString(self)?.integerValue
		}
	}
	
	///将表示十六进制数据的字符串转换为对应的二进制数据
	///
	///- Parameter string:形如“6E7C2F”的字符串
	///- Returns: 对应的二进制数据
	public func hexStringToData() ->NSData?
	{
		let hexString:NSString = self.uppercaseString.stringByReplacingOccurrencesOfString(" ", withString:"")
		if (hexString.length % 2 != 0) {
			return nil
		}
		var tempbyt:[UInt8] = [0]
		let bytes = NSMutableData(capacity: hexString.length / 2)
		for(var i = 0; i < hexString.length; ++i)
		{
			let hex_char1:unichar = hexString.characterAtIndex(i)
			var int_ch1:Int
			if(hex_char1 >= 48 && hex_char1 <= 57)
			{
				int_ch1 = (Int(hex_char1) - 48) * 16
			}
			else if(hex_char1 >= 65 && hex_char1 <= 70)
			{
				int_ch1 = (Int(hex_char1) - 55) * 16
			}
			else
			{
				return nil;
			}
			i++;
			let hex_char2:unichar = hexString.characterAtIndex(i)
			var int_ch2:Int
			if(hex_char2 >= 48 && hex_char2 <= 57)
			{
				int_ch2 = (Int(hex_char2) - 48)
			}
			else if(hex_char2 >= 65 && hex_char2 <= 70)
			{
				int_ch2 = Int(hex_char2) - 55;
			}
			else
			{
				return nil;
			}
			
			tempbyt[0] = UInt8(int_ch1 + int_ch2)
			bytes!.appendBytes(tempbyt, length:1)
		}
		return bytes;
	}
}