//
//  TableViewController.m
//  SimpleREST
//
//  Created by Ashari Juang on 7/31/15.
//  Copyright (c) 2015 KodeJS. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (strong) NSArray *questionsJSON;
@end

@implementation TableViewController
@synthesize questionsJSON;


- (void)DownloadData {
    //I use NSMutableString so we could append or replace parts of the URI with query parameters in the future
    // Gunakan NSMutableString
    NSMutableString *remoteUrl = [NSMutableString stringWithFormat:@"http://localhost:3000/api/v1/questions"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:remoteUrl] ];
    NSError *jsonError = nil;
    NSHTTPURLResponse *jsonResponse = nil;
    
    NSData *response;
    do {
        response = [NSURLConnection sendSynchronousRequest:request returningResponse:&jsonResponse error:&jsonError];
    } while ([jsonError domain] == NSURLErrorDomain);
    
    if([jsonResponse statusCode] != 200) {
        NSLog(@"%ld", (long)[jsonResponse statusCode]);
    } else {
        NSLog(@"%@", @"200 OK");
    }
    NSError* error;
    if(response) {
        //fishJson was defined earlier near the top as a NSArray object
        questionsJSON = [NSJSONSerialization
                    JSONObjectWithData:response
                    options:kNilOptions
                    error:&error];
    }
}

- (void)viewDidLoad {
    // semua method yang akan dipanggil di letakan disini
    [super viewDidLoad];
    [self DownloadData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [questionsJSON count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell" forIndexPath:indexPath];
    
    //temporary data to demonstrate the structure of a NSDictionary in an NSArray, which is the general structure of a JSON, this can be removed in a later stage
    /*NSArray *questions = @[
                        @{@"name": @"Dory", @"created": @"2014-06-21T04:23:01.639Z"},
                        @{@"name": @"Angel", @"created": @"2014-07-21T04:23:01.639Z"},
                        @{@"name": @"Clown", @"created": @"2014-08-21T04:23:01.639Z"}
                        ];
    */
    // response format from server
    /*[{
        id: 4,
    question: "Use the virtual RAM monitor, then you can input the redundant circuit!",
    created_at: "2015-06-04T12:35:52.636Z",
    updated_at: "2015-06-05T01:54:00.165Z",
    exam_id: 1
    },
    {
        id: 5,
    question: "You can't index the hard drive without backing up the cross-platform SSL pixel!",
    created_at: "2015-06-04T12:35:52.640Z",
    updated_at: "2015-06-05T01:54:05.542Z",
    exam_id: 1
    }]
    */
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuestionCell"];
    }
    
    //We will replace fishes with fishJson once we have code that downloads from the REST api
    [cell.textLabel setText:[[questionsJSON objectAtIndex:indexPath.row] objectForKey:@"question"] ];
    [cell.detailTextLabel setText:[[questionsJSON objectAtIndex:indexPath.row] objectForKey:@"created_at"]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

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
