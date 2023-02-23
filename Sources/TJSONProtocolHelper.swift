//
//  TJSONProtocolHelper.swift
//
//
//  Created by Khodabakhsh, Hojjat on 2/21/23.
//
import Foundation

public class TJSONProtocolHelper {

    /**
     Convert a byte containing a hex value to its corresponding hex character
     */
    public static func toHexChar(_ val: UInt8) -> UInt8 {
        var value = val & 0x0F
        if (value < 10) {
            let zeroChar = Character("0").asciiValue!
            return value + zeroChar
        }
        value -= 10
        let aChar = Character("a").asciiValue!
        return value + aChar
    }

    /**
     Return true if the given byte could be a valid part of a JSON number.
     */
    public static func isJsonNumeric(_ val: UInt8) -> Bool {
        let numberBytes = "+-.0123456789Ee".asciiBytes()
        if (numberBytes.contains(val)) {
            return true
        }
        return false
    }

    public static func getTypeIdForTypeName(_ name: [UInt8]) throws -> TType {
        var result = TType.stop
        if (name.count > 1) {
            switch(name[0]) {
            case "t".asciiBytes()[0]:
                result = TType.bool
            case "i".asciiBytes()[0]:
                switch(name[1]) {
                case "8".asciiBytes()[0]:
                    result = TType.i8
                case "1".asciiBytes()[0]:
                    result = TType.i16
                case "3".asciiBytes()[0]:
                    result = TType.i32
                case "6".asciiBytes()[0]:
                    result = TType.i64
                default:
                    result = TType.stop
                }
            case "d".asciiBytes()[0]:
                result = TType.double
            case "l".asciiBytes()[0]:
                result = TType.list
            case "m".asciiBytes()[0]:
                result = TType.map
            case "r".asciiBytes()[0]:
                result = TType.struct
            case "s".asciiBytes()[0]:
                if (name[1] == "t".asciiBytes()[0]) {
                    result = TType.string
                } else if (name[1] == "e".asciiBytes()[0]) {
                    result = TType.set
                }
            default:
                result = TType.stop
            }
        }

        if (result == TType.stop) {
            throw TProtocolError(error: .notImplemented, message: "Unrecognized exType")
        }

        return result
    }

    public static func getTypeNameForTypeId(_ typeId: TType) throws -> [UInt8] {
        switch(typeId) {
        case .bool:
            return TJSONProtocolConstants.TypeNames.NameBool
        case .i8:
            return TJSONProtocolConstants.TypeNames.NameByte
        case .i16:
            return TJSONProtocolConstants.TypeNames.NameI16
        case .i32:
            return TJSONProtocolConstants.TypeNames.NameI32
        case .i64:
            return TJSONProtocolConstants.TypeNames.NameI64
        case .double:
            return TJSONProtocolConstants.TypeNames.NameDouble
        case .string:
            return TJSONProtocolConstants.TypeNames.NameString
        case .struct:
            return TJSONProtocolConstants.TypeNames.NameStruct
        case .map:
            return TJSONProtocolConstants.TypeNames.NameMap
        case .set:
            return TJSONProtocolConstants.TypeNames.NameSet
        case .list:
            return TJSONProtocolConstants.TypeNames.NameList
        default:
            throw TProtocolError(error: .invalidData, message: "TypeId: \(typeId) does not have mapping Name")
        }
    }
}

// MARK: Extensions
extension String {
    public func asciiBytes() -> [UInt8] {
        var result: [UInt8] = []
        for char in self {
            result.append(char.asciiValue!)
        }
        return result
    }

    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

extension Character {
    public func asciiByte() -> UInt8 {
       return self.asciiValue!
    }
}

extension UInt8 {
    public func asCharacter() -> Character {
        let scalar = UnicodeScalar(self)
        return Character(scalar)
    }
}

extension UInt16 {
    public func isHighSurrogate() throws -> Bool {
        let wch = self
        if let d800 = UInt16("D800", radix: 16),
           let dbff = UInt16("DBFF", radix: 16) {
            return wch >= d800 && wch <= dbff
        } else {
            throw TProtocolError(error: .invalidData, message: "isHighSurrogate failed")
        }
    }

    public func isLowSurrogate() throws -> Bool{
        let wch = self
        if let dc00 = UInt16("DC00", radix: 16),
           let dfff = UInt16("DFFF", radix: 16) {
            return wch >= dc00 && wch <= dfff
        } else {
            throw TProtocolError(error: .invalidData, message: "isLowSurrogate failed")
        }
    }
}

extension TTransport {
    func writeJSONColon() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.Colon, count: TJSONProtocolConstants.Colon.count))
    }

    func writeJSONComma() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.Comma, count: TJSONProtocolConstants.Comma.count))
    }

    func writeJSONQuote() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.Quote, count: TJSONProtocolConstants.Quote.count))
    }

    func writeJSONBackslash() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.Backslash, count: TJSONProtocolConstants.Backslash.count))
    }

    func writeJSONEscSequences() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.EscSequences, count: TJSONProtocolConstants.EscSequences.count))
    }

    func writeJSONLeftBrace() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.LeftBrace, count: TJSONProtocolConstants.LeftBrace.count))
    }

    func writeJSONRightBrace() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.RightBrace, count: TJSONProtocolConstants.RightBrace.count))
    }

    func writeJSONLeftBracket() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.LeftBracket, count: TJSONProtocolConstants.LeftBracket.count))
    }

    func writeJSONRightBracket() throws {
        try self.write(data: Data(bytes: TJSONProtocolConstants.RightBracket, count: TJSONProtocolConstants.RightBracket.count))
    }
}
