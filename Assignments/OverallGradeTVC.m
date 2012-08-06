//
//  OverallGradeTVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 21/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "OverallGradeTVC.h"

@interface OverallGradeTVC ()

@end

@implementation OverallGradeTVC

@synthesize cachedModules, gradesArray,modulesArray,gradesAndModules,sortedArray,modulesOverallArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    modules *module = [[modules alloc]init];
    coursework *cw = [[coursework alloc]init];
    assignments *as = [[assignments alloc]init];
    
    modulesArray = [[NSMutableArray alloc]init];
    gradesArray = [[NSMutableArray alloc]init];
    modulesOverallArray = [[NSMutableArray alloc]init];
    
    double total;
    double total_weight;
    NSNumber *t;
    
    cachedModules = [ModulesCache getCachedMenuItems];
    
    for(int i=0; i<[cachedModules count];i++){
        
        module = [cachedModules objectAtIndex:i];
        NSMutableArray *cwArray =[[NSMutableArray alloc]init];
        cwArray = module.courseworkArray;
        
        for(int j=0;j<[cwArray count];j++){
            cw = [cwArray objectAtIndex:j];
            NSMutableArray *asArray =[[NSMutableArray alloc]init];
            asArray = cw.assignmentsArray;
            
            total_weight=0;
            total=0;
            
            for(int m=0;m<[asArray count];m++){
                
                as = [asArray objectAtIndex:m];
                
                NSString *ModuleTitle = module.title;
                NSString *mark = as.mark;
                NSNumber *weight = as.weight;
                
                if(mark !=nil){
                    grades *gr = [[grades alloc]init];
                    gr.grade = mark;
                    gr.assignment=as.title;
                    gr.module = ModuleTitle;
                    gr.weight = weight;
                    
                    [modulesOverallArray addObject:gr];
                    //     total = total + [mark doubleValue];
                    total_weight = total_weight + [weight doubleValue];
                    
                }
            }
        }
        
        grades *gr = [[grades alloc]init];
        
        //       NSLog([NSString stringWithFormat:@"%f , %f, %@", total, total_weight, t]);
        
        if(total_weight !=0){
            for(int i=0;i<[modulesOverallArray count];i++){
                gr= [modulesOverallArray objectAtIndex:i];
                total += [gr.grade doubleValue] * ([gr.weight doubleValue]/total_weight);
                t = [NSNumber numberWithDouble:total];
            }
        }
        //            if(total_weight == 1.0){
        //                for(int i=0;i<[modulesOverallArray count];i++){
        //                    gr= [modulesOverallArray objectAtIndex:i];
        //                    total += [gr.grade doubleValue] * ([gr.weight doubleValue]/1.0);
        //                    t = [NSNumber numberWithDouble:total];
        //                }
        //            }
        //            else if(total_weight == 2.0){
        //                for(int i=0;i<[modulesOverallArray count];i++){
        //                    gr= [modulesOverallArray objectAtIndex:i];
        //                    total += [gr.grade doubleValue] * ([gr.weight doubleValue]/2.0);
        //                    t = [NSNumber numberWithDouble:total];
        //                }
        //            }
        //            else if(total_weight == 100.0){
        //                for(int i=0;i<[modulesOverallArray count];i++){
        //                    gr= [modulesOverallArray objectAtIndex:i];
        //              //      NSLog(gr.grade);
        //                    total += [gr.grade doubleValue] * ([gr.weight doubleValue]/100.0);
        //                    t = [NSNumber numberWithDouble:total];
        //                }
        //            }
        //            else if(total_weight == 7.0){
        //                for(int i=0;i<[modulesOverallArray count];i++){
        //                    gr= [modulesOverallArray objectAtIndex:i];
        //                    total += [gr.grade doubleValue] * ([gr.weight doubleValue]/7.0);
        //                    t = [NSNumber numberWithDouble:total];
        //                }
        //            }
        else{
            total =0;
            t = [NSNumber numberWithDouble:total];
        }
        
        [modulesOverallArray removeAllObjects];
        grades *gra = [[grades alloc]init];
        gra.grade = [NSString stringWithFormat:@"%@",t];
        // [gradesArray addObject:t];
        gra.module = module.title;
        [gradesArray addObject:gra];
    }
    
    sortedArray = [gradesArray sortedArrayUsingComparator:^(id a, id b) {
        NSString *first = [(grades*)a grade];
        NSString *second = [(grades*)b grade];
        return [first compare:second];
    }];
    
    sortedArray = [[sortedArray reverseObjectEnumerator] allObjects];
    
    
    [self.tableView reloadData];
    
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [gradesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OverallCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    grades *gr = [[grades alloc]init];
    gr = [sortedArray objectAtIndex:[indexPath row]];
    NSString *overallgrade = gr.grade;
    // Configure the cell...
    
    //  [tableView setBackgroundColor:[UIColor clearColor]];
    
    CustomCellBackgroundView *bg = [[CustomCellBackgroundView alloc]init];
    UIImage *image = [UIImage imageNamed:@"Background.png"];
    bg.backgroundColor = [UIColor colorWithPatternImage:image];
    bg.borderColor = [UIColor darkGrayColor];        
    [cell setBackgroundView:bg];
    
    [cell setHighlighted:YES];
    
    if([overallgrade doubleValue] >= 16.5){
        bg.position = CustomCellBackgroundViewPositionTop;
        bg.fillColor = [UIColor lightGrayColor];
        [cell setBackgroundView:bg];
    }
    else if([overallgrade doubleValue] >= 13.5 && [overallgrade doubleValue] < 16.5){
        bg.position = CustomCellBackgroundViewPositionMiddle;
        bg.fillColor = [UIColor darkGrayColor];
        [cell setBackgroundView:bg];
    }
    else if([overallgrade doubleValue] < 13.5 && [overallgrade doubleValue] >=7.5){
        bg.position = CustomCellBackgroundViewPositionBottom;
        bg.fillColor = [UIColor blackColor];
        [cell setBackgroundView:bg];
    }
    else {
        bg.position = CustomCellBackgroundViewPositionBottom;
        bg.fillColor = [UIColor lightGrayColor];
        [cell setBackgroundView:bg];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:26];
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    
    if([overallgrade isEqualToString:@"0"]){
        cell.textLabel.text = @"Pending ...";
    }
    else if([overallgrade length] >4){
        cell.textLabel.text = [overallgrade substringToIndex:4];
    }
    else{
        cell.textLabel.text = overallgrade;
    }
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:22];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@",gr.module];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

@end
