//
//  HotelsListVC.m
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import "HotelsListVC.h"
#import "Hotel.h"
#import "HotelStore.h"
#import "HotelTC.h"
#import "UIActionSheet+Blocks.h"

@interface HotelsListVC ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *hotelsArray;
@property (nonatomic, assign) NSComparisonResult (^comparatorBlock)(id obj1, id obj2);
@end

@implementation HotelsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.comparatorBlock = ^(id obj1, id obj2){
        if ([obj1 doubleValue] > [obj2 doubleValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 doubleValue] < [obj2 doubleValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    [self fetchHotels];
}

#pragma mark - Private methods

-(void)fetchHotels{
    __block typeof(self) weakself = self;
    [[HotelStore sharedStore] getHotels:^(NSArray *hotels) {
        weakself.hotelsArray = [hotels mutableCopy];
        [weakself refreshTable];
    }];
}

-(void)sortHotelsOnTotalRate
{
    NSSortDescriptor *totalRateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"totalRate" ascending:YES comparator:self.comparatorBlock];
    NSArray *descriptors = [NSArray arrayWithObject:totalRateSortDescriptor];
    self.hotelsArray = [self.hotelsArray sortedArrayUsingDescriptors:descriptors];
    [self refreshTable];
}

-(void)sortHotelsOnDistance
{
    NSSortDescriptor *distanceSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES comparator:self.comparatorBlock];
    NSArray *descriptors = [NSArray arrayWithObject:distanceSortDescriptor];
    self.hotelsArray = [self.hotelsArray sortedArrayUsingDescriptors:descriptors];
    [self refreshTable];
}

-(void)sortHotelsOnStarRating
{
    NSSortDescriptor *starRatingSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"starRating" ascending:NO];
    NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:starRatingSortDescriptor, nameSortDescriptor,nil];
    self.hotelsArray = [self.hotelsArray sortedArrayUsingDescriptors:descriptors];
    [self refreshTable];
}

-(void)refreshTable
{
    [self.tableView reloadData];
}

#pragma mark - IBAction
- (IBAction)sortHotels:(id)sender {
    [UIActionSheet showInView:self.view
                    withTitle:@"Sort Hotels"
            cancelButtonTitle:@"Cancel"
       destructiveButtonTitle:nil
            otherButtonTitles:@[@"Total Rate", @"Distance", @"Rating"]
                     tapBlock: ^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                         if (buttonIndex == 0) {
                             [self sortHotelsOnTotalRate];
                         }
                         else if (buttonIndex == 1)
                         {
                             [self sortHotelsOnDistance];
                         }
                         else if (buttonIndex == 2)
                         {
                             [self sortHotelsOnStarRating];
                         }
                     }];
}

#pragma mark - UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.hotelsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelTC *cell = [tableView dequeueReusableCellWithIdentifier:ALReusableHotelCellIdentifier forIndexPath:indexPath];
    [cell layoutHotel:[self.hotelsArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

@end
