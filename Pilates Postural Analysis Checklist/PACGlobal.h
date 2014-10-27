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

// Side View Checklist
typedef enum {
    sideViewCheckListAnkleJoint = (1 << 0)
        , sideViewCheckListKnee = (1 << 1)
        , sideViewCheckListHipJoint = (1 << 2)
        , sideViewCheckListPelvis   = (1 << 3)
        , sideViewCheckListLumbar   = (1 << 4)
} PACChecklistSideView_t;

// Side View Ankle
typedef enum {
    ankleAlignmentNeutral = 0
        ,ankleAlignmentPlantarflex = 1
        ,ankleAlignmentDorsiflex = 2
} PACAnkleAlignment_t;

// Side View Knee
typedef enum {
    kneeSideAlignmentNeutral = 0
        ,kneeSideAlignmentHyperextended = 1
        ,kneeSideAlignmentFlexed = 2
} PACKneeSideAlignment_t;

// Side View Hip
typedef enum {
    hipAlignmentNeutral = 0
        ,hipAlignmentExtended = 1
        ,hipAlignmentFlexed = 2
} PACHipAlignment_t;

// Side View Pelvis
typedef enum {
    pelvisSideAlignmentNeutral = 0
        ,pelvisSideAlignmentAnteriorTilt = 1
        ,pelvisSideAlignmentPosteriorTilt = 2
} PACPelvisSideAlignment_t;

// Side View Lumbar Spine
typedef enum {
    lumbarAlignmentNeutral = 0
        ,lumbarAlignmentFlat = 1
        ,lumbarAlignmentFlexed = 2
} PACLumbarAlignment_t;

extern unsigned int PACChecklistMain;
extern unsigned int PACPlumbLineAlignment;

extern unsigned int PACChecklistSideView;

extern int PACAnkleAlignmentLeft;
extern int PACAnkleAlignmentRight;

extern int PACKneeAlignmentSideLeft;
extern int PACKneeAlignmentSideRight;

extern int PACHipAlignmentLeft;
extern int PACHipAlignmentRight;

extern int PACPelvisSideAlignmentLeft;
extern int PACPelvisSideAlignmentRight;

extern int PACLumbarAlignment;

extern const char* PACCheckListMainDidChange;
extern const char* PACCheckListSideViewDidChange;


#endif

