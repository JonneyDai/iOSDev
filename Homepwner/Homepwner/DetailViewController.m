//
//  DetailViewController.m
//  Homepwner
//
//  Created by 代隽杰 on 16/1/6.
//  Copyright © 2016年 gree. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "ImageStore.h"

@interface DetailViewController () <UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel     *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar   *toolbar;

@end

@implementation DetailViewController

-(void) viewDidLayoutSubviews
{
    //检查view中是否存在有歧义布局的子视图
    for (UIView *subview in self.view.subviews) {
        if ([subview hasAmbiguousLayout]) {
            NSLog(@"AMBIGOUS:%@",subview);
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *mItem              = self.item;
    self.nameField.text         = mItem.itemName;
    self.serialNumberField.text = mItem.serialNumber;
    self.valueField.text        = [NSString stringWithFormat:@"%d",mItem.valueInDollars];

    self.nameField.placeholder  = @"Enter name";
    
    //创建NSDateFormatter对象，用于将NSDate对象换成简单的日期字符串
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    //将转换后得到的日期字符串设置为dateLabel的标题
    self.dateLabel.text     = [dateFormatter stringFromDate:mItem.dateCreated];

    NSString *itemKey       = self.item.itemKey;
    //根据itemKey，从ImageStore对象获取照片
    UIImage *imageToDisplay = [[ImageStore sharedStore]imageForKey:itemKey];
    //将得到的照片赋给UIImageView对象
    self.imageView.image    = imageToDisplay;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    BNRItem *mItem       = self.item;
    mItem.itemName       = self.nameField.text;
    mItem.serialNumber   = self.serialNumberField.text;
    mItem.valueInDollars = [self.valueField.text intValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTapped:(id)sender {
    //进一步确定缺少哪种约束，推测自动布局另一种布局方式
    for (UIView *subview in self.view.subviews) {
        if ([subview hasAmbiguousLayout]) {
            [subview exerciseAmbiguityInLayout];
        }
    }
    
    [self.view endEditing:YES];
}

#pragma mark - Action
- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    NSArray *availableTypes   = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePicker.mediaTypes    = availableTypes;
    imagePicker.delegate      = self;
    imagePicker.allowsEditing = YES;
    
    //以模态的形式显示UIImagePickerController对象
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}


#pragma mark - UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //通过info字典获取选择的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
//    NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
//    if (mediaURL) {
//        //确定设备是否支持视频
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([mediaURL path])) {
//            //将视频存入相册
//            UISaveVideoAtPathToSavedPhotosAlbum([mediaURL path], nil, nil, nil);
//            //删除临时目录下的视频
//            [[NSFileManager defaultManager]removeItemAtPath:[mediaURL path] error:nil];
//            
//        }
//    }
//    
    [[ImageStore sharedStore]setImage:image forKey:self.item.itemKey];
    
    //将照片放入UIImageView对象
    self.imageView.image = image;
    
    //关闭UIImagePickerController对象
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
