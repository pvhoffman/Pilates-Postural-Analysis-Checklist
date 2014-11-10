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
        mainChecklistPlumbline               = (1 << 0)
            , mainChecklistAlignedInRelation = (1 << 1)
            , mainChecklistSideView          = (1 << 2)
            , mainChecklistFrontView         = (1 << 3)
            , mainChecklistBackView          = (1 << 4)
} PACChecklistMain_t;

typedef enum {
        plumbHeadForward            = (1 << 0)
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
    sideViewCheckListAnkleJoint          = (1 << 0)
        , sideViewCheckListKnee          = (1 << 1)
        , sideViewCheckListHipJoint      = (1 << 2)
        , sideViewCheckListPelvis        = (1 << 3)
        , sideViewCheckListLumbar        = (1 << 4)
        , sideViewCheckListLowerThoracic = (1 << 5)
        , sideViewCheckListUpperThoracic = (1 << 6)
        , sideViewCheckListCervicalSpine = (1 << 7)
        , sideViewCheckListHead          = (1 << 8)
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

// Side View Lower Thoracic
typedef enum {
    lowerThoracicAlignmentNeutral = 0
        , lowerThoracicAlignmentFlat = 1
        , lowerThoracicAlignmentFlexed = 2
} PACLowerThoracicAlignment_t;

// Side View Upper Thoracic
typedef enum {
    upperThoracicAlignmentNeutral      = 0
        , upperThoracicAlignmentFlat   = 1
        , upperThoracicAlignmentFlexed = 2
} PACUpperThoracicAlignment_t;

// Side View Cervical Spine
typedef enum {
    cervicalSpineAlignmentNeutral      = 0
        , cervicalSpineAlignmentFlat   = 1
        , cervicalSpineAlignmentFlexed = 2
} PACCervicalSpineAlignment_t;

// Side View Head
typedef enum {
        headSideAlignmentNeutral         = 0
            , headSideAlignmentForward   = 1
            , headSideAlignmentRetracted = 2
}PACHeadSideAlignment_t;

// Front View Check List
typedef enum {
        frontViewCheckListFeet            = (1 << 0)
            , frontViewCheckListKnees     = (1 << 1)
            , frontViewCheckListPelvis    = (1 << 2)
            , frontViewCheckListRibcage   = (1 << 3)
            , frontViewCheckListShoulders = (1 << 4)
            , frontViewCheckListHead      = (1 << 5)
} PACChecklistFrontView_t;

// Front View Feet
typedef enum {
    feetFrontAlignmentNeutral        = 0
        , feetFrontAlignmentInverted = 1
        , feetFrontAlignmentEverted  = 2
}PACFeetFrontAlignment_t;

// Front View Knees
typedef enum {
        kneeFrontAlignmentNeutral       = 0
            , kneeFrontAlignmentKnocked = 1
            , kneeFrontAlignmentBow     = 2
} PACKneeFrontAlignment_t;

// Front View Pelvis
typedef enum {
    pelvisFrontAlignmentLevel                         = 0
        , pelvisFrontAlignmentElevatedLeft            = 1
        , pelvisFrontAlignmentElevatedRight           = 2
        , pelvisFrontAlignmentRotatedClockwise        = 3
        , pelvisFrontAlignmentRotatedCounterClockwise = 4
} PACPelvisFrontAlignment_t;

// Front View Rib Cage
typedef enum {
    ribCageAlignmentNeutral                       = 0
        , ribCageAlignmentElevatedLeft            = (1 << 0)
        , ribCageAlignmentElevatedRight           = (1 << 2)
        , ribCageAlignmentShiftedLeft             = (1 << 3)
        , ribCageAlignmentShiftedRight            = (1 << 4)
        , ribCageAlignmentRotatedClockwise        = (1 << 5)
        , ribCageAlignmentRotatedCounterClockwise = (1 << 6)
}PACRibCageFrontAlignment_t;


// Front View Shoulders
typedef enum {
    shouldersFrontAlignmentLevel = (1 << 0)
        , shouldersFrontAlignmentElevatedLeft   = (1 << 1)
        , shouldersFrontAlignmentElevatedRight  = (1 << 2)
        , shouldersFrontAlignmentDepressedLeft  = (1 << 3)
        , shouldersFrontAlignmentDepressedRight = (1 << 4)
} PACShouldersFrontAlignment_t;

// Front View Head
typedef enum {
        headFrontAlignmentNeutral                       = (1 << 0)
            , headFrontAlignmentRotatedClockwise        = (1 << 2)
            , headFrontAlignmentRotatedCounterClockwise = (1 << 3)
            , headFrontAlignmentTiltedLeft              = (1 << 4)
            , headFrontAlignmentTiltedRight             = (1 << 5)
            , headFrontAlignmentShiftedLeft             = (1 << 6)
            , headFrontAlignmentShiftedRight            = (1 << 7)
}PACHeadFrontAlignment_t;

// Back View Check List
typedef enum {
        backViewCheckListFeet           = (1 << 0)
            , backViewCheckListFemurs   = (1 << 1)
            , backViewCheckListPelvis   = (1 << 2)
            , backViewCheckListScapulae = (1 << 3)
            , backViewCheckListHumeri   = (1 << 4)
} PACChecklistBackView_t;

// Back View Feet
typedef enum {
    feetBackAlignmentNeutral        = 0
        , feetBackAlignmentInverted = 1
        , feetBackAlignmentEverted  = 2
}PACFeetBackAlignment_t;



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

extern int PACLowerThoracicAlignment;
extern int PACUpperThoracicAlignment;
extern int PACCervicalSpineAlignment;
extern int PACHeadSideAlignment;

extern unsigned int PACChecklistFrontView;

extern int PACFeetFrontAlignmentLeft;
extern int PACFeetFrontAlignmentRight;

extern int PACKneeFrontAlignmentLeft;
extern int PACKneeFrontAlignmentRight;

extern int PACPelvisFrontAlignment;

extern int PACRibCageFrontAlignment;

extern int PACShouldersFrontAlignment;

extern int PACHeadFrontAlignment;


extern unsigned int PACChecklistBackView;

extern int PACFeetBackAlignmentLeft;
extern int PACFeetBackAlignmentRight;

extern const char* PACCheckListMainDidChange;
extern const char* PACCheckListSideViewDidChange;
extern const char* PACCheckListFrontViewDidChange;
extern const char* PACCheckListBackViewDidChange

#endif

