//
//  MPRFlickrSearch.h
//  WildKingdom
//
//  Created by Manas Pradhan on 3/29/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPRFlickrSearch : NSObject
-(void)FlickrPhotoSearch:(NSString*)searchString storeIn:(NSMutableArray*)arrayOfFlickrPhotos update:(UICollectionView*)collectionView;
@end
