//
//  PACFlatBackEssentailMatworkLayer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    flatBackEssentialMatworkLayer1 = 0
        , flatBackEssentialMatworkLayer2 
        , flatBackEssentialMatworkLayer3 
        , flatBackEssentialMatworkLayerCount
} PACFlatBackEssentialMatworkLayer_t;

@interface PACFlatBackEssentialMatworkLayer : UITableViewController
{
}
-(void) setLayer:(PACFlatBackEssentialMatworkLayer_t)layer;
@end
