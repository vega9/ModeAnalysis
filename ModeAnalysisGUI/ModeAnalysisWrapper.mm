#import <Foundation/Foundation.h>
#import "ModeAnalysisWrapper.h"
#import "include/ModeAnalysis.h"
#import <iostream>
#import <vector>

using namespace std;

@implementation ObjCppModeAnalysis : NSObject

-(id)init{
    self = [super init];
    if (self) {
        _cppModeAnalysis = new ModeAnalysis();
    }
    return self;
}



-(void)setPallalelogram {
    (*(ModeAnalysis*)_cppModeAnalysis).setPallalellogram();
}

-(void)setVerticesAndFaces:(NSArray *)vertices faces:(NSArray*)faces{
    vector<ModeAnalysis::xyz> vertices_cpp;
    int vn = (int)[vertices count];
    for (int i=0; i<vn; i++) {
        NSArray* vertex = (NSArray*)[vertices objectAtIndex:i];
        double x,y,z;
        x = [[vertex objectAtIndex:0] doubleValue];
        y = [[vertex objectAtIndex:1] doubleValue];
        z = [[vertex objectAtIndex:2] doubleValue];
        
        
        ModeAnalysis::xyz v_cpp = {x,y,z};
        vertices_cpp.push_back(v_cpp);
    }
    
    vector<vector<int> > faces_cpp;
    int fn = (int)[faces count];
    for (int i=0; i<fn; i++) {
        NSArray* face = (NSArray*)[faces objectAtIndex:i];
        int pn = (int)[face count];
        vector<int> face_cpp;
        for(int j=0;j<pn;j++){
            int fID = [[face objectAtIndex:j] intValue];
            face_cpp.push_back(fID);
        }
        faces_cpp.push_back(face_cpp);
    }
    ((ModeAnalysis*)_cppModeAnalysis)->setVerticesandFaces(vertices_cpp, faces_cpp);
    
}

-(void)solveEigenValueProblem{
    (*(ModeAnalysis*)_cppModeAnalysis).solveEigenProblem();
}

-(NSArray*)getEigenValue{
    vector<double> vals = (*(ModeAnalysis*)_cppModeAnalysis).getEigenValues();
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    int n = vals.size();
    for (int i=0; i<n; i++) {
        [arr addObject:[NSNumber numberWithDouble:vals[i]]];
    }
    return arr;
}

-(NSArray*)getEigenVector:(int) ID{
    vector<double> vec = (*(ModeAnalysis*)_cppModeAnalysis).getEigenVector(ID);
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    int n = vec.size();
    for (int i=0; i<n; i++) {
        [arr addObject:[NSNumber numberWithDouble:vec[i]]];
    }
    return arr;
}

@end

















