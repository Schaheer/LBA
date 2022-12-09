
#import <Foundation/Foundation.h>

@interface NSData (VeridiumCrypto)
- (NSData* _Nonnull)AES256EncryptWithKey:(NSString * _Nonnull)key;
- (NSData* _Nullable)AES256DecryptWithKey:(NSString * _Nonnull)key;
@end

@interface NSString (VeridiumCrypto)
- (NSString* _Nonnull)AES256EncryptToBase64StringWithKey:(NSString * _Nonnull)key;
- (NSString* _Nullable)AES256DecryptBase64StringWithKey:(NSString * _Nonnull)key;
@end

