//
//  PortsoundiaCollectionViewController.m
//  Portsoundia
//
//  Created by Dana Silver on 7/11/15.
//  Copyright (c) 2015 Dana Silver. All rights reserved.
//

#import "PortsoundiaCollectionViewController.h"
@import AVFoundation;

@interface PortsoundiaCollectionViewController () {
    NSArray *items;
    NSMutableDictionary *sounds;
}

@end

@implementation PortsoundiaCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    items = [NSArray arrayWithObjects:@"every_time_you_point", nil];
    sounds = [[NSMutableDictionary alloc] init];
    
    for (NSString *item in items) {

        NSString  *soundFilePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"PortsoundiaSounds/%@", item]
                                                                   ofType:@"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
                                                                       error:nil];
        [player prepareToPlay];

        [sounds setObject:player forKey:item];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *portsoundiaImageView = (UIImageView *)[cell viewWithTag:100];
    portsoundiaImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"PortsoundiaImages/%@", [items objectAtIndex:indexPath.row]]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self isPlayingAudio]) {
        AVAudioPlayer *player = [sounds objectForKey:[items objectAtIndex:indexPath.item]];
        [player play];
    }
}

- (BOOL)isPlayingAudio {
    for (NSString *key in sounds) {
        AVAudioPlayer *player = [sounds objectForKey:key];
        
        if (player.isPlaying) return YES;
    }
    
    return NO;
}

@end
