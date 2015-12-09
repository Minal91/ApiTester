import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.generateHMACFor("4e8dbab33eb977e19a6db44bfaee9a77262efc5be72b4b3c705fad07a8d10dcb", data: "/api/auth/customers.json{\"user\":{\"email\":\"amsalemg@gmail.com\",\"first_name\":\"Gilad\",\"last_name\":\"Amsalem\",\"birthday\":\"2.11.84\",\"anniversary\":\"2.11.84\",\"password\":\"password84\"},\"client\":\"7aedb515dd34f0deb31c7fc2467dfc98279581ed37524ed9d4fb6167b1255dbd\"}")
//        checkCount()
        return true
    }
    func generateHMACFor(key:String,data:String) {
        let cKey  = key.cStringUsingEncoding(NSASCIIStringEncoding)
        let cData = data.cStringUsingEncoding(NSASCIIStringEncoding)
        var cHMAC = [CUnsignedChar](count: Int(CC_SHA256_DIGEST_LENGTH), repeatedValue: 0)
        let algorithm = CCHmacAlgorithm(kCCHmacAlgSHA1)
        CCHmac(algorithm, cKey!, Int(strlen(cKey!)), cData!, Int(strlen(cData!)), &cHMAC)
        let hmacData:NSData = NSData(bytes: cHMAC, length: (Int(CC_SHA256_DIGEST_LENGTH)))
        var hmacBase64 = hmacData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding76CharacterLineLength)
        print("generated sha1 value === \(hmacData.hexString)")
    }
}

extension NSData {
    var hexString : String {
        let buf = UnsafePointer<UInt8>(bytes)
        let charA = UInt8(UnicodeScalar("a").value)
        let char0 = UInt8(UnicodeScalar("0").value)
        //hex conversion function
        func itoh(i: UInt8) -> UInt8 {
            return (i > 9) ? (charA + i - 10) : (char0 + i)
        }
        let p = UnsafeMutablePointer<UInt8>.alloc(length * 2)
        for i in 0..<length {
            p[i*2] = itoh((buf[i] >> 4) & 0xF)
            p[i*2+1] = itoh(buf[i] & 0xF)
        }
        return NSString(bytesNoCopy: p, length: 40, encoding: NSUTF8StringEncoding, freeWhenDone: true)! as String
    }
}

