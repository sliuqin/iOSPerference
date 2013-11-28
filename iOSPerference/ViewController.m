//
//  ViewController.m
//  iOSPerference
//
//  Created by liuqin.sheng on 11/27/13.
//  Copyright (c) 2013 peaches. All rights reserved.
//

#import "ViewController.h"
#import "define.h"

@interface ViewController () {
    UITextField *textField;
    UIButton *buttonSave;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:USERINFO_NAME];
    textField.text = name;
    [self.view addSubview:textField];

    buttonSave = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [buttonSave setTitle:@"save" forState:UIControlStateNormal];
    [buttonSave setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [buttonSave addTarget:self action:@selector(buttonSaveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSave];

    // 监听
    [self userDefaultsObserver];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark buttonSave
- (void)buttonSaveClick {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:textField.text forKey:USERINFO_NAME];
    [textField endEditing:YES];
    [defaults synchronize];

    NSLog(@"%@", [defaults dictionaryRepresentation]);
}

#pragma mark UserDefaults
- (void)userDefaultsObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(userDefaultsChange) name:NSUserDefaultsDidChangeNotification
                 object:nil];
}

- (void)userDefaultsChange {
    NSLog(@"userDefaultsChange");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    textField.text = [defaults stringForKey:USERINFO_NAME];
}

@end