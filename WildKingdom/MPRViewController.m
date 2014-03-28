//
//  MPRViewController.m
//  WildKingdom
//
//  Created by Manas Pradhan on 3/27/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import "MPRViewController.h"
#import "MPRCollectionViewCell.h"

@interface MPRViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSString *flickrAPIKey;
    NSMutableArray *arrayOfFlickrPhotos;
    
    IBOutlet UICollectionView *myCollectionView;
    //IBOutlet MPRCollectionViewCell *myCollectionViewCell;
}
@end

@implementation MPRViewController

- (void)viewDidLoad
{
    
# pragma mark - connect to JSON file to receive data feed
    
    [super viewDidLoad];
    
    flickrAPIKey = @"b7be76edbd3b906f271fdc997561a95e";
    arrayOfFlickrPhotos = [NSMutableArray new];
    [self flickrPhotoSearch];
}

- (void)flickrPhotoSearch
{
    NSString* tags = @"=lions+tigers+bears";
    NSString* texts = @"text=lion+tiger+bear";
    
# pragma mark - connect to the flickr photo search URL to grab the initial JSON data
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&%@&per_page=20&format=json&nojsoncallback=1",flickrAPIKey,tags,texts]];
    
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
         
         [myCollectionView reloadData];
     }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

# pragma mark - return size of dictionary array
    
    return [arrayOfFlickrPhotos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
# pragma mark - return the created the image from the URL
    
    MPRCollectionViewCell* cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellID" forIndexPath:indexPath];
    
    NSData *imageData = [NSData dataWithContentsOfURL:arrayOfFlickrPhotos[indexPath.row]];
    UIImage* image = [UIImage imageWithData:imageData];
    cell.myImageView.image = image;
    
    return cell;
}

@end
