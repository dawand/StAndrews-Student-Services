
@interface BlockBasedActionSheet : UIActionSheet<UIActionSheetDelegate> {
}

@property (copy) void (^cancelBlock)();
@property (copy) void (^destructiveBlock)();

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle cancelAction:(void (^)())cancelBlock destructiveAction:(void (^)())destructiveBlock;

@end