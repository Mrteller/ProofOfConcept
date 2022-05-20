import UIKit

let name = #"\U00d0\U009a\U00d0\U00b8\U00d1\U0080\U00d0\U00b8\U00d0\U00bb\U00d0\U00bb \U00d0\U00a8\U00d0\U00b0\U00d1\U0082\U00d1\U0080\U00d0\U00be\U00d0\U00b2"#

//let name2 = "\u{00d0}\u{009a}\u{00d0}\u{00b8}\u{00d1}\u{0080}\u{00d0}\u{00b8}\u{00d0}\u{00bb}\u{00d0}\u{00bb }\u{00d0}\u{00a8}\u{00d0}\u{00b0}\u{00d1}\u{0082}\u{00d1}\u{0080}\u{00d0}\u{00be}\u{00d0}\u{00b2}"
//name2

//let urlString = "%d0%9a%d0%b8%d1%80%d0%b8%d0%bb%d0%bb %d0%a8%d0%b0%d1%82%d1%80%d0%be%d0%b2"
//let url = URL(dataRepresentation: urlString.data(using: .utf8)!, relativeTo: nil)
//let str = url.standardized

let strToDecode = "\u{00d0}\u{009a}\u{00d0}\u{00b8}\u{00d1}\u{0080}\u{00d0}\u{00b8}\u{00d0}\u{00bb}\u{00d0}\u{00bb}\u{00d0}\u{00a8}\u{00d0}\u{00b0}\u{00d1}\u{0082}\u{00d1}\u{0080}\u{00d0}\u{00be}\u{00d0}\u{00b2}"
let bytes = strToDecode.utf8CString

var newString = bytes.withUnsafeBufferPointer({ (bufferPointer: UnsafeBufferPointer<CChar>)in
    return String(cString: bufferPointer.baseAddress!)
})
print(newString)

let data = "\u{00d0}\u{009a}\u{00d0}\u{00b8}\u{00d1}\u{0080}\u{00d0}\u{00b8}\u{00d0}\u{00bb}\u{00d0}\u{00bb}\u{00d0}\u{00a8}\u{00d0}\u{00b0}\u{00d1}\u{0082}\u{00d1}\u{0080}\u{00d0}\u{00be}\u{00d0}\u{00b2}".data(using: .utf8)

let range = UInt(0)...50
for i in range {
    let name2 = String(data: data!, encoding: .init(rawValue: i))
    print(name2)
}

extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}

strToDecode.utf8DecodedString()
strToDecode.utf8EncodedString()
