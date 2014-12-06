//
//  PACGlobal.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/22/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PACGlobal.h"

// static const char* source_pdf = "Postural-Analysis-Guide.pdf";

static const char* db_filename = "pac.sqlite";


static struct sqlite3* pacDatabase = 0;

unsigned int PACChecklistMain      = 0;
unsigned int PACPlumbLineAlignment = 0;
unsigned int PACChecklistSideView  = 0;

int PACAnkleAlignmentLeft  = -1;
int PACAnkleAlignmentRight = -1;

const char* PACCheckListMainDidChange      = "PACCheckListMainDidChange";
const char* PACCheckListSideViewDidChange  = "PACCheckListSideViewDidChange";
const char* PACCheckListFrontViewDidChange = "PACCheckListFrontViewDidChange";
const char* PACCheckListBackViewDidChange  = "PACCheckListBackViewDidChange";



int PACKneeAlignmentSideLeft  = -1;
int PACKneeAlignmentSideRight = -1;

int PACHipAlignmentLeft  = -1;
int PACHipAlignmentRight = -1;


int PACPelvisSideAlignmentLeft  = -1;
int PACPelvisSideAlignmentRight = -1;


int PACLumbarAlignment = -1;

int PACLowerThoracicAlignment = -1;
int PACUpperThoracicAlignment = -1;
int PACCervicalSpineAlignment = -1;

int PACHeadSideAlignment = -1;

unsigned int PACChecklistFrontView = 0;

int PACFeetFrontAlignmentLeft  = -1;
int PACFeetFrontAlignmentRight = -1;

int PACKneeFrontAlignmentLeft  = -1;
int PACKneeFrontAlignmentRight = -1;

int PACPelvisFrontAlignment = -1;

int PACRibCageFrontAlignment = -1;

int PACShouldersFrontAlignment = 0;

int PACHeadFrontAlignment = 0;


unsigned int PACChecklistBackView = 0;

int PACFeetBackAlignmentLeft  = -1;
int PACFeetBackAlignmentRight = -1;


int PACFemurBackAlignmentLeft  = -1;
int PACFemurBackAlignmentRight = -1;

int PACPelvisBackAlignment = 0;


int PACScapulaeBackAlignmentLeft  = -1;
int PACScapulaeBackAlignmentRight = -1;

int PACHumeriBackAlignmentLeft  = -1;
int PACHumeriBackAlignmentRight = -1;

int PACSpineSequencing = 0;
int PACSpineImbalance  = 0;


UIImage* pac_plumbline_indicator()
{
	return [UIImage imageNamed:@"llb_ball_15.png"];
}
UIImage* pac_sideview_indicator()
{
	return [UIImage imageNamed:@"g_ball_15.png"];
}
UIImage* pac_frontview_indicator()
{
	return [UIImage imageNamed:@"o_ball_15.png"];
}
UIImage* pac_backview_indicator()
{
	return [UIImage imageNamed:@"p_ball_15.png"];
}
static void pac_reset_plumbline()
{
    PACChecklistMain &= ~mainChecklistPlumbline;
    PACChecklistMain &= ~mainChecklistAlignedInRelation;
    PACPlumbLineAlignment = 0;
}
static void pac_reset_sideview()
{
    PACChecklistMain            &= ~mainChecklistSideView;
    PACChecklistSideView         = 0;
    PACAnkleAlignmentLeft        = -1;
    PACAnkleAlignmentRight       = -1;
    PACKneeAlignmentSideLeft     = -1;
    PACKneeAlignmentSideRight    = -1;
    PACHipAlignmentLeft          = -1;
    PACHipAlignmentRight         = -1;
    PACPelvisSideAlignmentLeft   = -1;
    PACPelvisSideAlignmentRight  = -1;
    PACLumbarAlignment           = -1;
    PACLowerThoracicAlignment    = -1;
    PACUpperThoracicAlignment    = -1;
    PACCervicalSpineAlignment    = -1;
    PACHeadSideAlignment         = -1;
}
static void pac_reset_frontview()
{
    PACChecklistMain           &= ~mainChecklistFrontView;
    PACChecklistFrontView       = 0;
    PACFeetFrontAlignmentLeft   = -1;
    PACFeetFrontAlignmentRight  = -1;
    PACKneeFrontAlignmentLeft   = -1;
    PACKneeFrontAlignmentRight  = -1;
    PACPelvisFrontAlignment     = -1;
    PACRibCageFrontAlignment    = -1;
    PACShouldersFrontAlignment  = 0;
    PACHeadFrontAlignment       = 0;
}
static void pac_reset_backview()
{
    PACChecklistMain              &= ~mainChecklistBackView;
    PACChecklistBackView           = 0;
    PACFeetBackAlignmentLeft       = -1;
    PACFeetBackAlignmentRight      = -1;
    PACFemurBackAlignmentLeft      = -1;
    PACFemurBackAlignmentRight     = -1;
    PACPelvisBackAlignment         = 0;
    PACScapulaeBackAlignmentLeft   = -1;
    PACScapulaeBackAlignmentRight  = -1;
    PACHumeriBackAlignmentLeft     = -1;
    PACHumeriBackAlignmentRight    = -1;
    PACSpineSequencing             = 0;
    PACSpineImbalance              = 0;
}
void pac_reset_all()
{
    pac_reset_plumbline();
    pac_reset_sideview();
    pac_reset_frontview();
    pac_reset_backview();
}

static NSString* pac_document_path()
{
    return [NSSearchPathForDirectoriesInDomains ( NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
static NSString* pac_database_filename()
{
    return [pac_document_path()stringByAppendingPathComponent:[NSString stringWithUTF8String:db_filename]];
}

static void pac_init_analysis_table()
{
    int rc = sqlite3_exec(pacDatabase
            , "create table if not exists analysis_t (analysis_index integer primary key autoincrement not null"\
            ", analysis_name text"\
            ", analysis_datetime text"\
            ", analysis_plumbline integer default 0"\
            ", analysis_sideview integer default 0"\
            ", analysis_frontview integer default 0"\
            ", analysis_backview integer default 0);"
            , 0, 0, 0);
    if(!(rc == SQLITE_OK || rc == SQLITE_DONE) ) {
        const char* errmsg = sqlite3_errmsg(pacDatabase);
        NSLog(@"Sqlite error: %s", errmsg);
    }
}
static void pac_init_plumbline_table()
{
    int rc = sqlite3_exec(pacDatabase
            , "create table if not exists plumbline_t (plumbline_index integer primary key autoincrement not null"\
            ", plumbline_analysis integer default 0"\
            ", plumbline_alignment integer default 0);"
            , 0, 0, 0);
    if(!(rc == SQLITE_OK || rc == SQLITE_DONE) ) {
        const char* errmsg = sqlite3_errmsg(pacDatabase);
        NSLog(@"Sqlite error: %s", errmsg);
    }
}
static void pac_init_sideviewtable()
{
    int rc = sqlite3_exec(pacDatabase
            , "create table if not exists sideview_t (sideview_index integer primary key autoincrement not null"\
            ", sideview_analysis integer default 0"\
            ", sideview_ankle_left integer default 0"\
            ", sideview_ankle_right integer default 0"\
            ", sideview_knee_left integer default 0"\
            ", sideview_knee_right integer default 0"\
            ", sideview_hip_left integer default 0"\
            ", sideview_hip_right integer default 0"\
            ", sideview_pelvis_left integer default 0"\
            ", sideview_pelvis_right integer default 0"\
            ", sideview_lumbar integer default 0"\
            ", sideview_thoracic_lower integer default 0"\
            ", sideview_thoracic_upper integer default 0"\
            ", sideview_cervical integer default 0"\
            ", sideview_head integer default 0);"
            , 0, 0, 0);
    if(!(rc == SQLITE_OK || rc == SQLITE_DONE) ) {
        const char* errmsg = sqlite3_errmsg(pacDatabase);
        NSLog(@"Sqlite error: %s", errmsg);
    }

}
static void pac_init_frontview_table()
{
    int rc = sqlite3_exec(pacDatabase
            , "create table if not exists frontview_t (frontview_index integer primary key autoincrement not null"\
            ", frontview_analysis integer default 0"\
            ", frontview_foot_left integer default 0"\
            ", frontview_foot_right integer default 0"\
            ", frontview_knee_left integer default 0"\
            ", frontview_knee_right integer default 0"\
            ", frontview_pelvis integer default 0"\
            ", frontview_ribcage integer default 0"\
            ", frontview_shoulders integer default 0"\
            ", frontview_head integer default 0);"
           , 0, 0, 0);
    if(!(rc == SQLITE_OK || rc == SQLITE_DONE) ) {
        const char* errmsg = sqlite3_errmsg(pacDatabase);
        NSLog(@"Sqlite error: %s", errmsg);
    }

}
static void pac_init_backview_table()
{
    int rc = sqlite3_exec(pacDatabase
            , "create table if not exists backview_t (backview_index integer primary key autoincrement not null"\
            ", backview_analysis integer default 0"\
            ", backview_foot_left integer default 0"\
            ", backview_foot_right integer default 0"\
            ", backview_femur_left integer default 0"\
            ", backview_femur_right integer default 0"\
            ", backview_pelvis integer default 0"\
            ", backview_scapulae_left integer default 0"\
            ", backview_scapulae_right integer default 0"\
            ", backview_humeri_left integer default 0"\
            ", backview_humeri_right integer default 0"\
            ", backview_sequence integer default 0"\
            ", backview_imbalance integer default 0);"\
           , 0, 0, 0);
    if(!(rc == SQLITE_OK || rc == SQLITE_DONE) ) {
        const char* errmsg = sqlite3_errmsg(pacDatabase);
        NSLog(@"Sqlite error: %s", errmsg);
    }

}
static void pac_init_database()
{
    pac_init_analysis_table();
    pac_init_plumbline_table();
    pac_init_sideviewtable();
    pac_init_frontview_table();
    pac_init_backview_table();
}

static void pac_open_database()
{
    BOOL exists = NO;
    NSString* filename = pac_database_filename();

    NSLog(@"Database is located at %@", filename);
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filename]) {
        exists = YES;
    }
    sqlite3_open([filename UTF8String], &pacDatabase);

    if(NO == exists){
        pac_init_database();
    }
}
static struct sqlite3* pac_database()
{
        if(!pacDatabase){
                pac_open_database();
        }
        return pacDatabase;
} 
static void pac_save_analysis_plumbline()
{
        
}
void pac_save_analysis(const char* name)
{
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , "insert into analysis_t (analysis_name, analysis_datetime) values (?, ?)"
            , -1
            , &stmt
            , 0);
    sqlite3_bind_text(stmt, 1, name, -1, 0);
    sqlite3_bind_text(stmt, 2, date_time, -1, 0);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);

    pac_save_analysis_plumbline();
        
}


#if 0



void create_document()
{
	NSString* source_path = [[NSBundle mainBundle] pathForResource:@"Postural-Analysis-Guide" ofType:@"pdf"];

	if(source_path) {
		NSURL* source_url = [NSURL fileURLWithPath:source_path];
		CGPDFDocumentRef source_doc = CGPDFDocumentCreateWithURL((__bridge CFURLRef)source_url);
		if(source_doc) {
			CGPDFDocumentRelease(source_doc);
		}
	}
}




- (void)helloWorldPDF {
	// Open the source pdf
	NSURL               *sourceURL      = [NSURL fileURLWithPath:@"path to original pdf"];
	CGPDFDocumentRef sourceDoc       = CGPDFDocumentCreateWithURL((__bridge CFURLRef)sourceURL);

	// Create the new destination pdf & set the font
	NSURL               *destURL        = [NSURL fileURLWithPath:@"path to new pdf"];
	CGContextRef destPDFContext  = CGPDFContextCreateWithURL((__bridge CFURLRef)destURL, NULL, NULL);
	CGContextSelectFont(destPDFContext, "CourierNewPS-BoldMT", 12.0, kCGEncodingFontSpecific);

	// Copy the first page of the source pdf into the destination pdf
	CGPDFPageRef pdfPage         = CGPDFDocumentGetPage(sourceDoc, 1);
	CGRect pdfCropBoxRect  = CGPDFPageGetBoxRect(pdfPage, kCGPDFMediaBox);
	CGContextBeginPage  (destPDFContext, &pdfCropBoxRect);
	CGContextDrawPDFPage(destPDFContext, pdfPage);

	// Close the source file
	CGPDFDocumentRelease(sourceDoc);

	// Draw the text
	const char *text = "second line!";
	CGContextShowTextAtPoint(destPDFContext, 10.0, 30.0, text, strlen(text));

	// Close the destination file
	CGContextRelease(destPDFContext);
}

#endif
