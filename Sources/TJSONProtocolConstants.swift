//
//  File.swift
//
//
//  Created by Khodabakhsh, Hojjat on 2/21/23.
//
import Foundation

/**
 TJSONProtocol Constants properties/fields
 */
public struct TJSONProtocolConstants {
    public static let Comma: [UInt8] = ",".asciiBytes()
    public static let Colon: [UInt8] = ":".asciiBytes()
    public static let LeftBrace: [UInt8] = "{".asciiBytes()
    public static let RightBrace: [UInt8] = "}".asciiBytes()
    public static let LeftBracket: [UInt8] = "[".asciiBytes()
    public static let RightBracket: [UInt8] = "]".asciiBytes()
    public static let Quote: [UInt8] = "\"".asciiBytes()
    public static let Backslash: [UInt8] = "\\".asciiBytes()

    public static let JsonCharTable: [UInt8] = [
        0, 0, 0, 0, 0, 0, 0, 0, b, t, n, 0, f, r, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, qt, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    ]

    // \b -> \u{0008}
    // \f -> \u{000C}
    public static let EscapeChars: [Character] = ["\"", "\\", "/", "\u{0008}", "\u{000C}", "\n", "\r", "\t" ]
    public static let EscapeCharValues: [UInt8] = "\"\\/\u{0008}\u{000C}\n\r\t".asciiBytes()
    public static let EscSequences: [UInt8] = "\\u00".asciiBytes()

    public struct TypeNames {
        public static let NameBool: [UInt8] = "tf".asciiBytes()
        public static let NameByte: [UInt8] = "i8".asciiBytes()
        public static let NameI16: [UInt8] = "i16".asciiBytes()
        public static let NameI32: [UInt8] = "i32".asciiBytes()
        public static let NameI64: [UInt8] = "i64".asciiBytes()
        public static let NameDouble: [UInt8] = "dbl".asciiBytes()
        public static let NameStruct: [UInt8] = "rec".asciiBytes()
        public static let NameString: [UInt8] = "str".asciiBytes()
        public static let NameMap: [UInt8] = "map".asciiBytes()
        public static let NameList: [UInt8] = "lst".asciiBytes()
        public static let NameSet: [UInt8] = "set".asciiBytes()
    }

    // MARK: private fields helpers
    private static let b: UInt8 = "b".asciiBytes()[0]
    private static let t: UInt8 = "t".asciiBytes()[0]
    private static let n: UInt8 = "n".asciiBytes()[0]
    private static let f: UInt8 = "f".asciiBytes()[0]
    private static let r: UInt8 = "r".asciiBytes()[0]
    private static let qt: UInt8 = "\"".asciiBytes()[0]
}
