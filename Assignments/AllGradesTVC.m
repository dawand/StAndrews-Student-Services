//
//  ViewController.m
//  Modules
//
//  Created by Dawand Sulaiman on 21/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "AllGradesTVC.h"

@interface AllGradesTVC ()
{
    BOOL reverse;
}

@end

@implementation AllGradesTVC

@synthesize cachedModules, gradesArray,modulesArray,gradesAndModules,sortedArray;


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
    modules *module = [[modules alloc]init];
    coursework *cw = [[coursework alloc]init];
    assignments *as = [[assignments alloc]init];
 //   grades *gr = [[grades alloc]init];

    modulesArray = [[NSMutableArray alloc]init];
    gradesArray = [[NSMutableArray alloc]init];

 //   asArray = [[NSMutableArray alloc]init];
    
    cachedModules = [ModulesCache getCachedMenuItems];
    
    for(int i=0; i<[cachedModules count];i++){
        
        module = [cachedModules objectAtIndex:i];
        NSMutableArray *cwArray =[[NSMutableArray alloc]init];
        cwArray = module.courseworkArray;
     //   [cwArray addObject:temp];
       
        for(int j=0;j<[cwArray count];j++){
        cw = [cwArray objectAtIndex:j];
        NSMutableArray *asArray =[[NSMutableArray alloc]init];
        asArray = cw.assignmentsArray;
    
            for(int m=0;m<[asArray count];m++){
//        
                as = [asArray objectAtIndex:m];
//        
                NSString *ModuleTitle = module.title;
                NSString *mark = as.mark;
//                NSNumber *weight = as.weight;
                
                    if(mark !=nil){
                        grades *gr = [[grades alloc]init];
                        gr.grade = mark;
                        gr.assignment=as.title;
                        gr.module = ModuleTitle;
                        [gradesArray addObject:gr];
                    }           
                }
        }
    }
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending: NO];
//    
//    sortedArray = (NSMutableArray *)[self.gradesArray sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
    
    sortedArray = [gradesArray sortedArrayUsingComparator:^(id a, id b) {
        NSString *first = [(grades*)a grade];
        NSString *second = [(grades*)b grade];
        return [first compare:second];
    }];
    
    // problems for marks under 7.5
    
    if(reverse){
        sortedArray = [[sortedArray reverseObjectEnumerator] allObjects];
    }
    
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
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sortedArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    grades *gr = [[grades alloc]init];
    gr = [sortedArray objectAtIndex: [indexPath row]];
    
    static NSString *CellIdentifier = @"GradesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
 
 //   [tableView setBackgroundColor:[UIColor clearColor]];
    
    UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    bgview.opaque = YES;
    
    if([gr.grade doubleValue] >= 16.5){
        bgview.backgroundColor = [UIColor lightGrayColor];
        [cell setBackgroundView:bgview];
    }
    else if([gr.grade doubleValue]>= 13.5 && [gr.grade doubleValue]< 16.5){
        bgview.backgroundColor = [UIColor darkGrayColor];
        [cell setBackgroundView:bgview];
    }
    else if([gr.grade doubleValue]>= 7.5 && [gr.grade doubleValue]< 13.5){
        bgview.backgroundColor = [UIColor blackColor];
        [cell setBackgroundView:bgview];
    }
    else if ([gr.grade doubleValue]< 7.5){
        bgview.backgroundColor = [UIColor blackColor];
        [cell setBackgroundView:bgview];
    }

    [cell setHighlighted:YES];
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:24];
    cell.textLabel.textColor = [UIColor yellowColor];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.text =gr.grade;

    cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:20];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@\n%@", gr.assignment,gr.module];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)SortTapped:(id)sender {
    reverse = TRUE;
    [self viewDidLoad];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [sender setEnabled:NO];
}

@end
