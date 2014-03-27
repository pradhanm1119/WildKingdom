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
    NSDictionary *flickrDictionary;
    NSArray *arrayOfFlickrDictionaries;
    
    IBOutlet UICollectionView *myCollectionView;
    IBOutlet MPRCollectionViewCell *myCollectionViewCell;
}
@end

@implementation MPRViewController

- (void)viewDidLoad
{
    
    #pragma mark - connect to JSON file to receive data feed
    
    NSURL *flickrURL = [NSURL URLWithString:@"https://api.flickr.com/services/feeds/photos_public.gne?format=json&key=b7be76edbd3b906f271fdc997561a95e"];
    NSURLRequest *flickrURLRequest = [NSURLRequest requestWithURL:flickrURL];
    
    [super viewDidLoad];
    
    [NSURLConnection sendAsynchronousRequest:flickrURLRequest queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         flickrDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
         
         arrayOfFlickrDictionaries = flickrDictionary[@"items"];
         //NSLog(@"%@", arrayOfFlickrDictionaries);
         
     }];
    
    //NSLog(@"%@", arrayOfFlickrDictionaries);

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    #pragma mark - return size of dictionary array
    return [arrayOfFlickrDictionaries count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    #pragma mark - WORK IN PROGRESS!!!
    
    UICollectionViewCell *cell = [[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellID" forIndexPath:[indexPath.row]] ];
    NSDictionary *dictionary = arrayOfFlickrDictionaries[indexPath.row];
    
    
}

@end
