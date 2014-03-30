//
//  MPRFlickrSearch.m
//  WildKingdom
//
//  Created by Manas Pradhan on 3/29/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import "MPRFlickrSearch.h"
@interface MPRFlickrSearch()
{}
@end

@implementation MPRFlickrSearch

NSString *const flickrAPIKey = @"b7be76edbd3b906f271fdc997561a95e";

-(void)FlickrPhotoSearch:(NSString*)searchString storeIn:(NSMutableArray*)arrayOfFlickrPhotos update:(UICollectionView*)collectionView
{    
# pragma mark - connect to the flickr photo search URL to grab the initial JSON data
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&%@&per_page=20&format=json&nojsoncallback=1",flickrAPIKey,searchString, searchString]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         NSError *error;
         
         NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
         
# pragma mark - grab photo data from the dictionary and feed it into an array
         
         NSArray* photos = jsonData[@"photos"][@"photo" ];
         
         for (NSDictionary* item in photos)
         {
             NSString* photoURL = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg",item[@"farm"],item[@"server"],item[@"id"],item[@"secret"]];
             
# pragma mark - store the URL for the photo in an array for use by the collection view
             
             [arrayOfFlickrPhotos addObject:[NSURL URLWithString:photoURL]];
         }
         
         [collectionView reloadData];
     }];
}

@end
