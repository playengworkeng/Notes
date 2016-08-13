//
//  ViewController.m
//  Notes
//
//  Created by J on 8/11/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()
@property(weak, nonatomic)UILabel* notesLabel;
@property(weak, nonatomic)UITextField* notesField;
@property(weak, nonatomic)UIButton* notesButton;
@property(weak, nonatomic)UITextView* notesView;
@property(copy, nonatomic)void (^completionBlockHandler)();

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(25, 50, 25, 25)];
    UITextField* textField = [[UITextField alloc]initWithFrame:CGRectMake(25, 50, 20, 50)];
    UIButton* textButton = [[UIButton alloc]initWithFrame:CGRectMake(25, 25, 50, 50)];
    UITextView* textView = [[UITextView alloc]initWithFrame:CGRectMake(100, 50, self.view.frame.size.width*.5, self.view.frame.size.height*.5)];
    
    
    label.text = @"Title:";
    [textButton setTitle:@"Save" forState:UIControlStateNormal];
    [textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [textButton addTarget:self action:@selector(tappedSave:) forControlEvents:UIControlEventTouchDown];
    textButton.layer.cornerRadius = 5;
    textButton.backgroundColor = [UIColor grayColor];
    textField.borderStyle = UITextBorderStyleLine;
    textField.delegate = self;
    
    //textView.backgroundColor = [UIColor grayColor];
    textView.layer.borderColor = [[UIColor blackColor] CGColor];
    textView.layer.borderWidth =1;

    
    
    
    [self.view addSubview: label];
    [self.view addSubview: textField];
    [self.view addSubview: textButton];
    [self.view addSubview: textView];
    
    self.notesLabel = label;
    self.notesField = textField;
    self.notesButton = textButton;
    self.notesView = textView;
    
    [self.notesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.leading.equalTo(self.view.mas_leading).with.offset(self.view.frame.size.width*.3);
        make.top.equalTo(self.view.mas_top).with.offset(50);
        
        
        
    }];
    
    
    [self.notesField mas_makeConstraints:^(MASConstraintMaker* make){
        
        make.leading.equalTo(self.notesLabel.mas_trailing).with.offset(10);
        make.top.equalTo(self.notesLabel.mas_top);
        make.width.equalTo(@(100));
    }];
    
    
    
    [self.notesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.notesField.mas_trailing).with.offset(10);
        make.top.equalTo(self.notesLabel.mas_top);
    }];
    
    
    [self.notesView mas_makeConstraints:^(MASConstraintMaker *make) {
        

//        make.leading.equalTo(self.view.mas_leading).with.offset(20);
//        make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
//        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.leading.equalTo(self.view.mas_leading).with.offset(30);
        make.trailing.equalTo(self.view.mas_trailing).with.offset(30);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        make.top.equalTo(self.notesLabel.mas_top).with.offset(50);
//        make.leading.equalTo(self.view.mas_leading).with.offset(30);
//        make.trailing.equalTo(self.view.mas_trailing).with.offset(30);
 //       make.height.equalTo(@(500));
        
    }];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    Note* note = [[Model sharedModel]loadNote];
    self.notesField.text = note.title;
    self.notesView.text = note.detail;
 
    
    
}


//Add yourself as an observer once the view appears
-(void)viewDidAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    
}

//Remove yourself as the observer once view disappears
-(void)viewDidDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tappedSave:(UIButton*)sender
{
    
    //if there is something in the notes field and text view, then save the note
    if(self.notesField.text.length > 0 && self.notesView.text.length >0)
    {
        [self saveNote];
        
    }
    
    else
    {
        [self noDataToSave];
    }
    

    
    NSLog(@"The save button was pressed");
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL responded = [textField resignFirstResponder];
    [self.notesView becomeFirstResponder];
    return responded;
}

-(void)keyboardWasShown:(NSNotification*)notification
{
    
    CGFloat keyboardHeight = [[[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size.height;
    [self.notesView mas_updateConstraints:^(MASConstraintMaker *make) {
  
       
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-(keyboardHeight + 10));
                                                              
    }];
                              

}


-(void)keyboardWillBeHidden:(NSNotification*)notification
{
    
    [self.notesView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-(10));
        
    }];
   
    
}



-(void)saveNote
{
    Note* note = [[Note alloc]initWithTitle:self.notesField.text detail:self.notesView.text];
    [[Model sharedModel]saveNote:note];
    
    
    //Adding visual alert for when user saves data
    UIAlertController* saveAlert = [UIAlertController alertControllerWithTitle:@"Save Alert" message:@"The item was saved" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [saveAlert addAction:alertAction];
    
    [self presentViewController:saveAlert animated:NO completion:nil];
    
}


-(void)noDataToSave
{
    
    NSString* wheresTheProblem;
    if(self.notesField.text.length <= 0)
    {
        wheresTheProblem = @"The problem is in notesfield";
        
    }
    
    
    else if(self.notesView.text.length <=0)
    {
        
        wheresTheProblem = @"The problem is in notesView";
    }
    
    else if(self.notesView.text.length <=0 && self.notesField.text.length <=0)
    {
      
        wheresTheProblem = @"The problem is in notesfield and text length";
    }
    
    NSString* theProblem = [NSString stringWithFormat:@"There need to be text in %@ to be able to save",wheresTheProblem];
    
    //Creating an alert
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save the problem" message:theProblem preferredStyle:UIAlertControllerStyleAlert];
    
    
    //Creating an alert action
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action) {
        
        if (self.notesField.text.length == 0)
        {
            [self.notesField becomeFirstResponder];
        }
        
        else
        {
            [self.notesView becomeFirstResponder];
        }
    }];
    
    
    //Adding an alert to AlertController
    [alert addAction:alertAction];
    
    [self presentViewController:alert animated:NO completion:nil];
    
    
    
    [self doThatThing:^{
        NSLog(@"That thing is done");
    }];
    
    
}


-(void)doThatThing:(void (^)())completionHandler
{
    self.completionBlockHandler = completionHandler;
    
    self.completionBlockHandler();
    
}
@end
