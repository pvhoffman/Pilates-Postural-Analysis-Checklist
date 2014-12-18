//
//  PACSwayBackEssentailMatworkLayer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    swayBackEssentialMatworkLayer1 = 0
        , swayBackEssentialMatworkLayer2 
        , swayBackEssentialMatworkLayer3 
        , swayBackEssentialMatworkLayerCount
} PACSwayBackEssentialMatworkLayer_t;

@interface PACSwayBackEssentialMatworkLayer : UITableViewController
{
}
-(void) setLayer:(PACSwayBackEssentialMatworkLayer_t)layer;
@end
