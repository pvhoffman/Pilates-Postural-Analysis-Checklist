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


int PACCurrentAnalysis = -1;

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

    PACCurrentAnalysis = -1;

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
            , "create table if not exists analysis_t (analysis_id integer primary key autoincrement not null"\
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
            , "create table if not exists plumbline_t (plumbline_id integer primary key autoincrement not null"\
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
            , "create table if not exists sideview_t (sideview_id integer primary key autoincrement not null"\
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
            , "create table if not exists frontview_t (frontview_id integer primary key autoincrement not null"\
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
            , "create table if not exists backview_t (backview_id integer primary key autoincrement not null"\
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
static void pac_save_analysis_plumbline(const int analysis_id)
{
    int rc;
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , "insert into plumbline_t (plumbline_analysis, plumbline_alignment) values (?, ?)"
            , -1
            , &stmt
            , 0);
    sqlite3_bind_int(stmt, 1, analysis_id);
    sqlite3_bind_int(stmt, 2, PACPlumbLineAlignment);
    rc = sqlite3_step(stmt);
    sqlite3_finalize(stmt);

    
    if(!(rc == SQLITE_OK || rc == SQLITE_DONE) ) {
        const char* errmsg = sqlite3_errmsg(db);
        NSLog(@"Sqlite error: %s", errmsg);
    }

    int rowid = (int)sqlite3_last_insert_rowid(db);

    sqlite3_prepare(db
            , "update analysis_t set analysis_plumbline = ? where analysis_id = ?"
            , -1
            , &stmt
            , 0);
    sqlite3_bind_int(stmt, 1, rowid);
    sqlite3_bind_int(stmt, 2, analysis_id);
    rc = sqlite3_step(stmt);
    sqlite3_finalize(stmt);

    if(!(rc == SQLITE_OK || rc == SQLITE_DONE) ) {
        const char* errmsg = sqlite3_errmsg(db);
        NSLog(@"Sqlite error: %s", errmsg);
    }
}
static void pac_save_analysis_sideview(const int analysis_id)
{
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , "insert into sideview_t (sideview_analysis, sideview_ankle_left, sideview_ankle_right, sideview_knee_left, sideview_knee_right, sideview_hip_left, sideview_hip_right"\
            " , sideview_pelvis_left, sideview_pelvis_right, sideview_lumbar, sideview_thoracic_lower, sideview_thoracic_upper, sideview_cervical, sideview_head)"\
            " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            , -1
            , &stmt
            , 0);

    sqlite3_bind_int(stmt, 1, analysis_id);

    sqlite3_bind_int(stmt, 2, PACAnkleAlignmentLeft);
    sqlite3_bind_int(stmt, 3, PACAnkleAlignmentRight);

    sqlite3_bind_int(stmt, 4, PACKneeAlignmentSideLeft);
    sqlite3_bind_int(stmt, 5, PACKneeAlignmentSideRight);
    
    sqlite3_bind_int(stmt, 6, PACHipAlignmentLeft);
    sqlite3_bind_int(stmt, 7, PACHipAlignmentRight);

    sqlite3_bind_int(stmt, 8, PACPelvisSideAlignmentLeft); 
    sqlite3_bind_int(stmt, 9, PACPelvisSideAlignmentRight); 
    
    sqlite3_bind_int(stmt, 10, PACLumbarAlignment);

    sqlite3_bind_int(stmt, 11, PACLowerThoracicAlignment);
    sqlite3_bind_int(stmt, 12, PACUpperThoracicAlignment);

    sqlite3_bind_int(stmt, 13, PACCervicalSpineAlignment); 

    sqlite3_bind_int(stmt, 14, PACHeadSideAlignment);

    sqlite3_step(stmt);
    sqlite3_finalize(stmt);

    int rowid = (int)sqlite3_last_insert_rowid(db);

    sqlite3_prepare(db
            , "update analysis_t set analysis_sideview = ? where analysis_id = ?"
            , -1
            , &stmt
            , 0);
    sqlite3_bind_int(stmt, 1, rowid);
    sqlite3_bind_int(stmt, 2, analysis_id);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
}
static void pac_save_analysis_frontview(const int analysis_id)
{    
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , "insert into frontview_t (frontview_analysis, frontview_foot_left, frontview_foot_right, frontview_knee_left, frontview_knee_right"\
            ", frontview_pelvis, frontview_ribcage, frontview_shoulders, frontview_head) values (?, ?, ?, ?, ?, ?, ?, ?, ?);"
            , -1
            , &stmt
            , 0);

    sqlite3_bind_int(stmt, 1, analysis_id);

    sqlite3_bind_int(stmt, 2, PACFeetFrontAlignmentLeft);
    sqlite3_bind_int(stmt, 3, PACFeetFrontAlignmentRight);

    sqlite3_bind_int(stmt, 4, PACKneeFrontAlignmentLeft);
    sqlite3_bind_int(stmt, 5, PACKneeFrontAlignmentRight);

    sqlite3_bind_int(stmt, 6, PACPelvisFrontAlignment); 

    sqlite3_bind_int(stmt, 7, PACRibCageFrontAlignment); 

    sqlite3_bind_int(stmt, 8, PACShouldersFrontAlignment); 

    sqlite3_bind_int(stmt, 9, PACHeadFrontAlignment);
    
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);

    int rowid = (int)sqlite3_last_insert_rowid(db);

    sqlite3_prepare(db
            , "update analysis_t set analysis_frontview = ? where analysis_id = ?"
            , -1
            , &stmt
            , 0);
    sqlite3_bind_int(stmt, 1, rowid);
    sqlite3_bind_int(stmt, 2, analysis_id);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
}

static void pac_save_analysis_backview(const int analysis_id)
{
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , "insert into backview_t (backview_analysis, backview_foot_left, backview_foot_right, backview_femur_left, backview_femur_right, backview_pelvis"\
              ", backview_scapulae_left, backview_scapulae_right, backview_humeri_left, backview_humeri_right, backview_sequence, backview_imbalance)"\
              " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
            , -1
            , &stmt
            , 0);

    sqlite3_bind_int(stmt, 1, analysis_id);

    sqlite3_bind_int(stmt, 2, PACFeetBackAlignmentLeft);
    sqlite3_bind_int(stmt, 3, PACFeetBackAlignmentRight);

    sqlite3_bind_int(stmt, 4, PACFemurBackAlignmentLeft);
    sqlite3_bind_int(stmt, 5, PACFemurBackAlignmentRight);

    sqlite3_bind_int(stmt, 6, PACPelvisBackAlignment);

    sqlite3_bind_int(stmt, 7, PACScapulaeBackAlignmentLeft);
    sqlite3_bind_int(stmt, 8, PACScapulaeBackAlignmentRight);

    sqlite3_bind_int(stmt, 9, PACHumeriBackAlignmentLeft);
    sqlite3_bind_int(stmt, 10, PACHumeriBackAlignmentRight);

    sqlite3_bind_int(stmt, 11, PACSpineSequencing);
    sqlite3_bind_int(stmt, 12, PACSpineImbalance);

    sqlite3_step(stmt);
    sqlite3_finalize(stmt);

    const int rowid = (int)sqlite3_last_insert_rowid(db);

    sqlite3_prepare(db
            , "update analysis_t set analysis_backview = ? where analysis_id = ?"
            , -1
            , &stmt
            , 0);
    sqlite3_bind_int(stmt, 1, rowid);
    sqlite3_bind_int(stmt, 2, analysis_id);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
}
static NSString* pac_current_datetime_string()
{
    NSDate* now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"MM/dd/yyyy hh:mma"];

    return [dateFormater stringFromDate:now];
}
void pac_save_analysis(const char* name, int analysis_id)
{
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    if(analysis_id < 0){

    NSString* date_time = pac_current_datetime_string();

    sqlite3_prepare(db
            , "insert into analysis_t (analysis_name, analysis_datetime) values (?, ?)"
            , -1
            , &stmt
            , 0);
    sqlite3_bind_text(stmt, 1, name, -1, 0);
    sqlite3_bind_text(stmt, 2, [date_time UTF8String], -1, 0);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);

        analysis_id = (int)sqlite3_last_insert_rowid(db);
    } 

    pac_save_analysis_plumbline(analysis_id);
    pac_save_analysis_sideview(analysis_id);
    pac_save_analysis_frontview(analysis_id);
    pac_save_analysis_backview(analysis_id);

    PACCurrentAnalysis = analysis_id;
}

static void pac_load_analysis_plumbline(const int analysis_id)
{
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , " select plumbline_alignment from plumbline_t where plumbline_analysis = ?"
            , -1
            , &stmt
            , 0);
    sqlite3_bind_int(stmt, 1, analysis_id);
    if(sqlite3_step(stmt) == SQLITE_ROW){
        PACPlumbLineAlignment = sqlite3_column_int(stmt, 0);
    }
    sqlite3_finalize(stmt);
}
static void pac_load_analysis_sideview(const int analysis_id)
{
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , "select sideview_ankle_left, sideview_ankle_right, sideview_knee_left, sideview_knee_right, sideview_hip_left, sideview_hip_right"\
            " , sideview_pelvis_left, sideview_pelvis_right, sideview_lumbar, sideview_thoracic_lower, sideview_thoracic_upper, sideview_cervical, sideview_head"\
            " from sideview_t where sideview_analysis = ?"
            , -1
            , &stmt
            , 0);

    sqlite3_bind_int(stmt, 1, analysis_id);
    if(sqlite3_step(stmt) == SQLITE_ROW){
        PACAnkleAlignmentLeft  = sqlite3_column_int(stmt, 0);
        PACAnkleAlignmentRight = sqlite3_column_int(stmt, 1);

        PACKneeAlignmentSideLeft  = sqlite3_column_int(stmt, 2);
        PACKneeAlignmentSideRight = sqlite3_column_int(stmt, 3);

        PACHipAlignmentLeft  = sqlite3_column_int(stmt, 4);
        PACHipAlignmentRight = sqlite3_column_int(stmt, 5);

        PACPelvisSideAlignmentLeft  = sqlite3_column_int(stmt, 6);
        PACPelvisSideAlignmentRight = sqlite3_column_int(stmt, 7);

        PACLumbarAlignment = sqlite3_column_int(stmt, 8);

        PACLowerThoracicAlignment = sqlite3_column_int(stmt, 9);
        PACUpperThoracicAlignment = sqlite3_column_int(stmt, 10);

        PACCervicalSpineAlignment = sqlite3_column_int(stmt, 11);

        PACHeadSideAlignment = sqlite3_column_int(stmt, 12);
    }
    sqlite3_finalize(stmt);
}
static void pac_load_analysis_frontview(const int analysis_id)
{
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , "select frontview_foot_left, frontview_foot_right, frontview_knee_left, frontview_knee_right"\
            ", frontview_pelvis, frontview_ribcage, frontview_shoulders, frontview_head from frontview_t where frontview_analysis = ?"
            , -1
            , &stmt
            , 0);

    sqlite3_bind_int(stmt, 1, analysis_id);
    if(sqlite3_step(stmt) == SQLITE_ROW){
         PACFeetFrontAlignmentLeft = sqlite3_column_int(stmt, 0);
         PACFeetFrontAlignmentRight = sqlite3_column_int(stmt, 1);

         PACKneeFrontAlignmentLeft = sqlite3_column_int(stmt, 2);
         PACKneeFrontAlignmentRight = sqlite3_column_int(stmt, 3);

         PACPelvisFrontAlignment = sqlite3_column_int(stmt, 4); 

         PACRibCageFrontAlignment = sqlite3_column_int(stmt, 5); 

         PACShouldersFrontAlignment = sqlite3_column_int(stmt, 6); 

         PACHeadFrontAlignment = sqlite3_column_int(stmt, 7);
 
    }
    sqlite3_finalize(stmt);

}
static void pac_load_analysis_backview(const int analysis_id)
{
    sqlite3_stmt* stmt = 0;
    struct sqlite3* db = pac_database();

    sqlite3_prepare(db
            , "select backview_foot_left, backview_foot_right, backview_femur_left, backview_femur_right, backview_pelvis"\
              ", backview_scapulae_left, backview_scapulae_right, backview_humeri_left, backview_humeri_right, backview_sequence, backview_imbalance"\
              " from backview_t where backview_analysis = ?"
            , -1
            , &stmt
            , 0);

    sqlite3_bind_int(stmt, 1, analysis_id);
    if(sqlite3_step(stmt) == SQLITE_ROW){
        PACFeetBackAlignmentLeft = sqlite3_column_int(stmt, 0);
        PACFeetBackAlignmentRight = sqlite3_column_int(stmt, 1);

        PACFemurBackAlignmentLeft = sqlite3_column_int(stmt, 2);
        PACFemurBackAlignmentRight = sqlite3_column_int(stmt, 3);

        PACPelvisBackAlignment = sqlite3_column_int(stmt, 4);

        PACScapulaeBackAlignmentLeft = sqlite3_column_int(stmt, 5);
        PACScapulaeBackAlignmentRight = sqlite3_column_int(stmt, 6);

        PACHumeriBackAlignmentLeft = sqlite3_column_int(stmt, 7);
        PACHumeriBackAlignmentRight = sqlite3_column_int(stmt, 8);

        PACSpineSequencing = sqlite3_column_int(stmt, 9);
        PACSpineImbalance = sqlite3_column_int(stmt, 10);
    }
    sqlite3_finalize(stmt);




}
void pac_load_analysis(const int analysis_id)
{
    pac_load_analysis_plumbline(analysis_id);
    pac_load_analysis_sideview(analysis_id);
    pac_load_analysis_frontview(analysis_id);
    pac_load_analysis_backview(analysis_id);
}

NSArray* pac_all_analysis()
{
        NSMutableArray* res = [[NSMutableArray alloc] init];
        sqlite3_stmt* stmt;
        struct sqlite3* db = pac_database();

        sqlite3_prepare(db
                , "select analysis_id from analysis_t"
                , -1
                , &stmt
                , 0);

        while(sqlite3_step(stmt) == SQLITE_ROW){
                [res addObject:[NSNumber numberWithInt:sqlite3_column_int(stmt, 0)]];
        }
        sqlite3_finalize(stmt);

        return res;
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
