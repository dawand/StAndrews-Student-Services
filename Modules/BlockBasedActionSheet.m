#import "BlockBasedActionSheet.h"

@implementation BlockBasedActionSheet
@synthesize cancelBlock = _cancelBlock, destructiveBlock = _destructiveBlock;

- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle cancelAction:(void (^)())cancelBlock destructiveAction:(void (^)())destructiveBlock
{
    self = [super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    if (self) {
        _cancelBlock = Block_copy(cancelBlock);
        _destructiveBlock = Block_copy(destructiveBlock);
    }
    return self;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSAssert(actionSheet == self, @"Wrong Action Sheet passed");
    if (buttonIndex == [self cancelButtonIndex]) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    } else {
        if (self.destructiveBlock) {
            self.destructiveBlock();
        }
    }
}

@end