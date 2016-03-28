//
//  TEClassExtension.swift
//
//  Created by macsjh on 16/3/7.
//  Copyright © 2016年 TurboExtension. All rights reserved.
//

import UIKit

extension NSURL{
	convenience init?(unSafeString:String){
		guard unSafeString.characters.count > 0 else {return nil}
		var urlString:String? = ""
		if(unSafeString.rangeOfString(":") == nil){
			urlString = "https://" + unSafeString
		}
		else {urlString = unSafeString}
		
		/*
		URLQueryAllowedCharacterSet() 相等 URLFragmentAllowedCharacterSet()
		URLQueryAllowedCharacterSet() 相交或相离 URLHostAllowedCharacterSet()
		URLQueryAllowedCharacterSet() 包含 URLPathAllowedCharacterSet()
		URLQueryAllowedCharacterSet() 包含 URLUserAllowedCharacterSet()
		URLQueryAllowedCharacterSet() 包含 URLPasswordAllowedCharacterSet()
		*/
		let allowSet =  NSMutableCharacterSet()
		allowSet.addCharactersInString("#")
		allowSet.formUnionWithCharacterSet(NSCharacterSet.URLQueryAllowedCharacterSet())
		allowSet.formUnionWithCharacterSet(NSCharacterSet.URLHostAllowedCharacterSet())
		urlString = urlString?.stringByRemovingPercentEncoding
		urlString = urlString!.stringByAddingPercentEncodingWithAllowedCharacters(allowSet)
		
		guard urlString != nil else {return nil}
		self.init(string: urlString!)
	}
	
	static func URLIsEqual(url1: String, url2: String) -> Bool{
		guard let u1 = NSURL(unSafeString: url1) else{return false}
		guard let u2 = NSURL(unSafeString: url2) else{return false}
		if u1 == u2 {return true}
		else if(u1.pathExtension?.characters.count > 0 || u2.pathExtension?.characters.count > 0){
			return false
		}
		else {
			return u1.URLByAppendingPathComponent("") == u2.URLByAppendingPathComponent("")
		}
	}
	
	func domainName() -> String?{
		guard let host = self.host else{return nil}
		let domains = host.componentsSeparatedByString(".")
		switch domains.count{
		case 0: return nil
		case 1, 2: return domains[0]
		default: return domains[1]
		}
	}
	
	/// remove all path extension and standardlize url.(read-only)
	var URLWithoutPathExtension:NSURL?{
		get
		{
			var tempURL:NSURL? = self
			while tempURL?.lastPathComponent?.characters.count > 0{
				tempURL = tempURL?.URLByDeletingLastPathComponent?.standardizedURL
			}
			return tempURL
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

extension UIColor{
	///	Convert hexString to UIColor
	///
	/// support:
	/// - "#012345" & "012345"
	/// - "#AABBCCEE" & "AABBCCEE"
	///
	///	- parameter hexString:	16进制字符串
	///
	///	- returns: 如果成功，初始化UIColor, 否则返回nil
	convenience init?(hexString:String){
		let hex:[Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
		let splitHex:(String) -> [CGFloat]? = {
			//			(String) -> [Int] in
			var num:Int? = nil
			var hexqueue:[CGFloat] = []
			for char in $0.characters{
				let i = hex.indexOf(char)
				guard i >= 0 else {return nil}
				if num == nil {num = i! * 16}
				else {hexqueue.append(CGFloat(num! + i!) / 255); num = nil}
			}
			return hexqueue
		}
		
		var startIndex = 0
		if hexString.characters.first == "#"{startIndex = 1}
		if hexString.characters.count == 8 + startIndex{
			guard let hexcolors = splitHex(hexString.subString(startIndex, length: 8))
				else {return nil}
			self.init(red: hexcolors[1], green: hexcolors[2], blue: hexcolors[3], alpha: hexcolors[0])
		}
		else if hexString.characters.count == 6 + startIndex{
			guard let hexcolors = splitHex(hexString.subString(startIndex, length: 6))
				else {return nil}
			self.init(red: hexcolors[0], green: hexcolors[1], blue: hexcolors[2], alpha: 1)
		}
		else{return nil}
	}
}