//
//  GXByteUtil.swift
//  GXPluginSample
//
//  Created by Gin on 2025/1/27.
//

import UIKit

// MARK: - 字节
// MARK: swift里，Byte就是UInt8，一个字节，8位
public extension UInt8 {
    var hexString: String {
        let str = String(format:"0x%02x", self)
        return str
    }
    var bString: String {
        // 转2进制，输出的内容是有效位，左侧的0没有
        var str = String(self, radix: 2)
        // 一个UInt用二进制来方，是8位
        let preCount = 8 - str.count
        if preCount > 0 {
            let preStr = Array(repeating: "0", count: preCount).joined()
            str = preStr + str
        }
        return str
    }
    // 读取对应位置上的数字（结果是0或者1）
    func readBit(index: Int) -> UInt8 {
        if index < 0 || index > 7 {
            return self
        }
        // 10010000 读取 第4位
        // 10010000 -> 10010000 & 00010000 -> 00010000 -> 1
        // 10010000 读取 第5位
        // 10010000 -> 10010000 & 00001000 -> 00000000 -> 0
        let moveStep = UInt8(7-index)
        // 只保留需要读取的位置上的值
        let val = (self & (0x1 << moveStep))
        // 将读取的位置上的值变成0或1
        let result = val >> moveStep
        return result
    }
    // 给对应位置上设置指定的值（只能设置0或者1），返回修改后的新值
    func writeBit(index: Int, value: Int) -> UInt8 {
        // 一个字节只有8位
        if index < 0 || index > 7 {
            return self
        }
        // 字节里设置的值只能是0或者1
        if value != 1, value != 0 {
            return self
        }
        // 10010001 设置 第3位 为0
        // 10010001 -> 10010001 & 11101111 -> 10000001 | 0000000 -> 10000001
        // 10010001 设置 第3位 为1
        // 10010001 -> 10010001 & 11101111 -> 10000001 | 0001000 -> 10010001
        // 10010001 设置 第4位 为1
        // 10010001 -> 10010001 & 11110111 -> 10010001 | 00001000 -> 10011001
        let moveStep = UInt8(7-index)
        // 读取到对应的位的设置为0内容
        let otherVal = (self & ~(0x1 << moveStep))
        // 要设置的值
        let setVal = UInt8(value) << moveStep
        // 将值合起来
        let result = otherVal | setVal
        return result
    }
    // 按bit位得到数字
    func numberVal(range: NSRange) -> Int {
        var binaryString: String = ""
        let start = range.location, end = range.location + range.length
        for i in start..<end {
            let bit: UInt8 = self.readBit(index: i)
            binaryString += "\(bit)"
        }
        guard let decimalNumber = Int(binaryString, radix: 2) else {
            return 0
        }
        return decimalNumber
    }
}

// MARK: - Data
// MARK: swift里，Data 与 [UInt8]、NSData是等价的
public extension Data {
    var nsData: NSData {
        return (self as NSData)
    }
    var bytes: [UInt8] {
        return [UInt8](self)
    }
    func subData(range: NSRange) -> Data {
        return self.nsData.subdata(with: range)
    }
    func subBytes(range: NSRange) -> [UInt8] {
        return self.subData(range: range).bytes
    }
    // MARK: - Data\Bytes -> 数字
    func numberVal<T: FixedWidthInteger>() -> T {
        // 当前类型需要几个字节来放
        let size = MemoryLayout<T>.size
        // 如果只需要一个字节，说明就是UInt8
        var val: T = 0
        var valData = self
        let addCount = size - self.count
        if addCount > 0 {
            // 说明长度不够，需要在前面补0
            let addData = ([UInt8](repeating: 0, count: addCount)).data
            valData = addData + valData
        } else if addCount < 0 {
            // 长度超过所需的长度，只使用后面的内容
            valData = self.subData(range: NSRange(location: self.count-size, length: size))
        }
        valData.nsData.getBytes(&val, length: size)
        let result = T(bigEndian: val)
        return result
    }
    var strVal: String? {
        return String(data: self, encoding: .utf8)
    }
    var hexString: String {
        self.map({ $0.hexString }).joined(separator: " ")
    }
    var bString: String {
        self.map({ $0.bString }).joined(separator: " ")
    }
}

// MARK: - 字节数组
public extension Array where Element == UInt8 {
    var data: Data {
        return Data(self)
    }
    var nsData: NSData {
        return self.data.nsData
    }
    func subData(range: NSRange) -> Data {
        return self.data.subData(range: range)
    }
    func subBytes(range: NSRange) -> [UInt8] {
        return self.data.subBytes(range: range)
    }
    func numberVal<T: FixedWidthInteger>() -> T {
        return self.data.numberVal()
    }
    var strVal: String? {
        return self.data.strVal
    }
    var hexString: String {
        return self.data.hexString
    }
    var bString: String {
        return self.data.bString
    }
    func crc16() -> UInt16 {
        let count = self.count
        var crc: UInt16 = 0
        for i in 0..<count {
            crc = crc ^ UInt16(self[i] << 8)
            for _ in 1..<8 {
                if ((crc & 0x8000) != 0) {
                    crc = crc << 1 ^ 0x1021
                } else {
                    crc = crc << 1
                }
            }
        }
        return (crc & 0xFFFF)
    }
}

// MARK: - 数字转化 -> Data\Bytes
public extension FixedWidthInteger {
    var bytes: [UInt8] {
        // 当前类型需要几个字节来放
        let size = MemoryLayout<Self>.size
        var bytes = [UInt8]()
        for i in 0..<size {
            let distance = (size - 1 - i) * 8;
            let sub  = self >> distance
            let value = UInt8(sub & 0xff)
            bytes.append(value)
        }
        return bytes
    }
    var data: Data {
        return self.bytes.data
    }
}

// MARK: - 范围扩展
public extension NSRange {
    var nextLocation: Int {
        return self.location + self.length
    }
    func nextRange(length: Int) -> NSRange {
        return NSRange(location: self.nextLocation, length: length)
    }
}
