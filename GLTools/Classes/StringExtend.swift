//
//  StringExtend.swift
//  FBSnapshotTestCase
//
//  Created by zoulin on 2017/11/27.
//

import Foundation

extension String
{
    
    // MARK: - 基础方法
    
    /// 字符串长度
    var length : Int
    {
        return countElements(self)
    }
    
    /**
     通过指定的String.Index得到该位置的Int索引
     
     :param: index 某字符的String.Index
     
     :returns: 该字符的Int索引
     */
    func getIntIndex(index : String.Index) -> Int
    {
        return distance(self.startIndex, self.endIndex) - 1
    }
    
    /**
     通过Int索引得到相应的String.Index
     
     :param: idx Int索引
     
     :returns: 对应的String.Index索引
     */
    func getIndexFormInt(idx :Int) -> String.Index
    {
        
        return advance(self.startIndex, idx)
    }
    
    // MARK: - 下标索引
    
    /**
     *  通过int索引取得或设置该位置上的字符
     *  eg. var str = "hello"
     *  str[0] = str[1]
     *  //"eello"
     */
    subscript (i: Int) -> Character
    {
        
        set
        {
            self.removeAtIndex(i)
            if i != self.length
            {
                self.insert(newValue, atIndex: i)
            }
            else
            {
                self.append(newValue)
            }
        }
        get
        {
            return self[self.getIndexFormInt(i)]
        }
    }
    
    /**
     *  通过所给的范围取得子串
     */
    subscript (subRange: Range<Int>) -> String
    {
        set
        {
            replaceRange(subRange, with: newValue)
        }
        get
        {
            return self[self.getIndexFormInt(subRange.startIndex)..<self.getIndexFormInt(subRange.endIndex)]
        }
        
    }
    
    // MARK: - 字符串修改（插入，删除，替换）
    
    /**
     删除某位置上的字符
     
     :param: i int索引
     
     :returns: 返回被删除的字符
     */
    mutating func removeAtIndex(i: Int) -> Character
    {
        return self.removeAtIndex(self.getIndexFormInt(i))
    }
    
    /**
     删除某范围中的字符（串）
     
     :param: subRange 原字符串中的索引范围
     */
    mutating func removeRange(subRange: Range<Int>)
    {
        let start = self.getIndexFormInt(subRange.startIndex)
        let end = self.getIndexFormInt(subRange.endIndex)
        self.removeRange(start..<end)
    }
    
    /**
     在指定位置插入字符（若插入字符串，请使用splice方法！）
     
     :param: newElement 被插入的新字符
     :param: i          插入的位置
     */
    mutating func insert(newElement: Character, atIndex i: Int)
    {
        self.insert(newElement, atIndex: self.getIndexFormInt(i))
    }
    
    /**
     在指定位置插入字符串
     
     :param: newElements 被插入的字符串
     :param: i           插入的位置
     */
    mutating func splice(newElements: String, atIndex i: Int)
    {
        self.splice(newElements, atIndex: getIndexFormInt(i))
    }
    
    /**
     用给定字符串替换给定的位置范围
     
     :param: subRange  被替换的范围
     :param: newValues 替换的字符串
     */
    mutating func replaceRange(subRange: Range<Int>, with newValues: String)
    {
        let start = self.getIndexFormInt(subRange.startIndex)
        let end = self.getIndexFormInt(subRange.endIndex)
        replaceRange(start..<end, with: newValues)
    }
    
    // MARK: - 字符串截取（subString）
    
    /**
     取出从头到某位置的子串（不包括索引位置的字符）
     
     :param: index 位置索引
     
     :returns: 返回子串
     */
    func substringToIndex(index: Int) -> String
    {
        return self.substringToIndex(self.getIndexFormInt(index))
    }
    
    /**
     取出从某位置到结尾的子串（包括索引位置的字符）
     
     :param: index 位置索引
     
     :returns: 返回子串
     */
    func substringFromIndex(index: Int) -> String
    {
        return self.substringFromIndex(self.getIndexFormInt(index))
    }
    
    /**
     取出一个范围中的子串
     
     :param: range 位置索引范围
     
     :returns: 返回子串
     */
    func substringWithRange(range: Range<Int>) -> String
    {
        let start = self.getIndexFormInt(range.startIndex)
        let end = self.getIndexFormInt(range.endIndex)
        return self.substringWithRange(start..<end)
    }
    
    // MARK: - 字符串拆分 (separated)
    
    /**
     以指定字符串为分割符，拆分字符串
     
     :param: separator 作为分隔符的字符串
     
     :returns: 返回分割后的字符串数组
     */
    func separatedByString(separator: String) -> [String]
    {
        let str:NSString = self
        return str.componentsSeparatedByString(separator) as [String]
    }
    
    /**
     以指定字符串内的每个字符作为分隔符，拆分字符串
     
     :param: separators 作为分隔符的字符集合
     
     :returns: 返回分割后的字符串数组
     */
    func separatedByCharacters(separators: String) -> [String]
    {
        let str:NSString = self
        return str.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: separators)) as [String]
    }
}
