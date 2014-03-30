//
//  MPRViewController.m
//  WildKingdom
//
//  Created by Manas Pradhan on 3/27/14.
//  Copyright (c) 2014 Manas Pradhan. All rights reserved.
//

#import "MPRViewController.h"
#import "MPRCollectionViewCell.h"
#import "MPRFlickrSearch.h"

@interface MPRViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITabBarControllerDelegate, UICollectionViewDelegateFlowLayout>
{
    NSString *flickrAPIKey;
    NSMutableArray *flickrPhotoArray;
    
    IBOutlet UICollectionView *myCollectionView;
    //IBOutlet MPRCollectionViewCell *myCollectionViewCell;
}
@end

@implementation MPRViewController

- (void)viewDidLoad
{

#pragma mark - load the app, brother
    
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    myCollectionView.delegate = self;
    
    flickrPhotoArray = [NSMutableArray new];
    MPRFlickrSearch *flickr = [MPRFlickrSearch new];
    [flickr FlickrPhotoSearch:@"denver+broncos" storeIn:flickrPhotoArray update:myCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

# pragma mark - return size of dictionary array
    
    return [flickrPhotoArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
# pragma mark - return the created the image from the URL
    
    MPRCollectionViewCell* cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCellID" forIndexPath:indexPath];
    
    NSData *imageData = [NSData dataWithContentsOfURL:flickrPhotoArray[indexPath.row]];
    UIImage* image = [UIImage imageWithData:imageData];
    cell.myImageView.image = image;
    
    return cell;
}

@end
