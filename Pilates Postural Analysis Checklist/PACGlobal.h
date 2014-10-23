//
//  PACGlobal.h
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/22/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#ifndef Pilates_Postural_Analysis_Checklist_PACGlobal_h
#define Pilates_Postural_Analysis_Checklist_PACGlobal_h

typedef enum {
        mainChecklistPlumbline = (1 << 0)
            , mainChecklistAlignedInRelation = (1 << 1)
            , mainChecklistSideView          = (1 << 2)
            , mainChecklistFrontView         = (1 << 3)
            , mainChecklistBackView          = (1 << 4)
} PACChecklistMain_t;

typedef enum {
        plumbHeadForward = (1 << 0)
            , plumbHeadAligned      = (1 << 1)
            , plumbHeadBehind       = (1 << 2)
            , plumbShouldersForward = (1 << 3)
            , plumbShouldersAligned = (1 << 4)
            , plumbShouldersBehind  = (1 << 5)
            , plumbUpperBodyForward = (1 << 6)
            , plumbUpperBodyAligned = (1 << 7)
            , plumbUpperBodyBehind  = (1 << 8)
            , plumbPelvisForward    = (1 << 9)
            , plumbPelvisAligned    = (1 << 10)
            , plumbPelvisBehind     = (1 << 11)
            , plumbKneesForward     = (1 << 12)
            , plumbKneesAligned     = (1 << 13)
            , plumbKneesBehind      = (1 << 14)
} PACPlumbLineAlignment_t;

extern unsigned int PACChecklistMain;
extern unsigned int PACPlumbLineAlignment;

extern const char* PACCheckListMainDidChange;
#endif
