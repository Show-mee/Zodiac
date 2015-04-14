//
//  AudioViewController.m
//  ChineseWheel
//
//  Created by GraceXu on 14/04/15.
//
//

#import "AudioViewController.h"

@interface AudioViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *background;

@end

@implementation AudioViewController

- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _background.image = [UIImage imageNamed:@"07background"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)jumpToStoryboard:(id)sender {
    
    
        UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self presentModalViewController:[secondStoryboard instantiateViewControllerWithIdentifier:@"FirstView"] animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
