
#import "CCApplication.h"

@implementation CCApplication

- (void)sendEvent:(NSEvent *)anEvent{
	
	if([anEvent type] == NSSystemDefined && [anEvent subtype] == 8){
		int data = [anEvent data1];
		int keyCode = ((data & 0xffff0000) >> 16);
		int keyFlags = (data & 0x0000ffff);
		int keyState = (((keyFlags & 0xff00) >> 8)) == 0xa;
		BOOL keyIsRepeat = (keyFlags & 0x1) > 0;
		
		if(keyState){
			int cr;
			switch(keyCode){
				case NX_KEYTYPE_PLAY:
					cr = system("cmus-remote -u");
					ALog(@"%d %d %d %d  Play", keyCode, keyState, keyIsRepeat, cr);
					break;
				
				case NX_KEYTYPE_FAST:
					cr = system("cmus-remote -n");
					ALog(@"%d %d %d %d  Next", keyCode, keyState, keyIsRepeat, cr);
					break;
				
				case NX_KEYTYPE_REWIND:
					cr = system("cmus-remote -r");
					ALog(@"%d %d %d %d  Previous", keyCode, keyState, keyIsRepeat, cr);
					break;
			}
		}
		
		// return;
	}
	
	[super sendEvent:anEvent];
}

@end
