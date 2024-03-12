//  NativeParser.swift
//  iosApp
//
//  Created by Rui Canas on 01/12/2023.
//

import qrose

extension KotlinByteArray {
    
    var toData: Data {

        var byteArray = [Int8]()
        for i in 0..<size {
            byteArray.append(self.get(index: i))
        }
        
        return Data(
            bytes: byteArray,
            count: byteArray.count
        )
    }
}

extension NSData {
    
    var toKotlinByteArray: KotlinByteArray {
        
        let byteCount = length
        return KotlinByteArray(size: Int32(byteCount)) { [weak self] index in
            var byte: Int8 = 0
            self?.getBytes(&byte, range: NSRange(location: Int(truncating: index), length: 1))
            return KotlinByte(value: byte)
        }
    }
}

extension Data {
    
    var toKotlinByteArary: KotlinByteArray { (self as NSData).toKotlinByteArray }
}

enum KotlinColor {
    static let Blue: UInt64 = 18374687574888284160
    static let Red: UInt64 = 18446462598732840960
}
