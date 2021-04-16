//
//  StringExtension.swift
//  MarvelCharactersPoC
//
//  Created by Amin Siddiqui on 16/04/21.
//

import CommonCrypto

extension String {
    
    ///Ref: https://www.agnosticdev.com/content/how-use-commoncrypto-apis-swift-5
    var md5: String {
        guard let strData = self.data(using: String.Encoding.utf8) else { return "" }
        
        /// #define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */
        /// Creates an array of unsigned 8 bit integers that contains 16 zeros
        var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
        
        /// CC_MD5 performs digest calculation and places the result in the caller-supplied buffer for digest (md)
        /// Calls the given closure with a pointer to the underlying unsafe bytes of the strData’s contiguous storage.
        strData.withUnsafeBytes {
            // CommonCrypto
            // extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md) --|
            // OpenSSL                                                                          |
            // unsigned char *MD5(const unsigned char *d, size_t n, unsigned char *md)        <-|
            CC_MD5($0.baseAddress, UInt32(strData.count), &digest)
        }
        
        
        var md5String = ""
        /// Unpack each byte in the digest array and add them to the md5String
        for byte in digest {
            md5String += String(format:"%02x", UInt8(byte))
        }
        
        return md5String
    }
}

