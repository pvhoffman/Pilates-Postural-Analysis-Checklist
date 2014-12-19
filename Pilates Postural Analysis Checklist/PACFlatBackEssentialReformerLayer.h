//
//  PACFlatBackEssentailReformer.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/15/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    flatBackEssentialReformerLayer1 = 0
        , flatBackEssentialReformerLayer2 
        , flatBackEssentialReformerLayer3 
        , flatBackEssentialReformerLayerCount
} PACFlatBackEssentialReformerLayer_t;

@interface PACFlatBackEssentialReformerLayer : UITableViewController
{
}
-(void) setLayer:(PACFlatBackEssentialReformerLayer_t)layer;
@end
