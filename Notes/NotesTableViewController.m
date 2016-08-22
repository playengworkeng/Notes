//
//  NotesTableViewController.m
//  Notes
//
//  Created by J on 8/14/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import "NotesTableViewController.h"
#import  <CoreLocation/CoreLocation.h>


@interface NotesTableViewController ()

@property(strong, nonatomic)Notes* notes;
@property(strong, nonatomic)Note* noteToAdd;

@end

@implementation NotesTableViewController


-(id)init{
    
    self = [super init];
    
    if (!self){
        
        return nil;
    }
    
    self.title = @"Notes";
    
    self.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"Notes" image:[UIImage imageNamed:@"Note"] tag:0 ];
    

    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[NoteTableViewCell class] forCellReuseIdentifier:@"note"];
//    self.notes = [[Notes alloc]initWithNotes:@[
//                                          [[Note alloc]initWithTitle:@"First Note" detail:@"First Note"],
//                                          [[Note alloc]initWithTitle:@"Second Note" detail:@"Second Note"]
//                                          ]
//                                        ];
    
    
    self.notes = [[Model sharedModel]notes];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNote:)];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Notes";

}


-(void)addNote:(id)sender {
    
    //add longitude and latitude to note
    self.noteToAdd = [[Note alloc]initWithTitle:@"" detail:@"" latitude:@(42.358280) longitude:@(-71.060966)];
    
    ViewController* viewController = [[ViewController alloc]initWithNote:self.noteToAdd];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    if (self.noteToAdd && ![self.noteToAdd isBlank])
    {
    
        [[[Model sharedModel]notes]addNote:self.noteToAdd];
        
        if(!self.notes.saved)
        {
            [[Model sharedModel]saveNotes];
            self.notes.saved= YES;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"NoteSaved" object:self];
        }
    
    }
    
    [self.tableView reloadData];
    
    self.noteToAdd = nil;
}



-(void)viewDidAppear:(BOOL)animated {
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveLog:) name:@"NoteSaved" object:nil];
    
}


-(void)viewDidDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSInteger count = self.notes.count;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"note" forIndexPath:indexPath];
 
    Note* note = [self.notes getNoteAtIndex:indexPath.item];
    
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = note.detail;
    
    return cell;
}



-(NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [NSArray array];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Note* note = [self.notes getNoteAtIndex:1];
    
    ViewController* notesViewController = [[ViewController alloc]initWithNote:note];
    
    [self.navigationController pushViewController:notesViewController animated:YES];
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     //Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
         //Delete the row from the data source
        if(!self.notes.saved)
        {
            [[Model sharedModel]saveNotes];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"NoteSaved" object:self];
        }
        [[[Model sharedModel]notes]deleteNodeAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    if(!self.notes.saved)
    {
        [[Model sharedModel]saveNotes];
      
         NSLog(@"%d",self.notes.saved);
         [[NSNotificationCenter defaultCenter]postNotificationName:@"NoteSaved" object:self];
        
        
    }
    [[[Model sharedModel]notes]moveFromIndex:fromIndexPath.row toIndex:toIndexPath.row];
    
    
}


-(void)saveLog:(NSNotification*)notification {
    
    self.notes.saved = YES;
    NSLog(@"%d",self.notes.saved);
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
