//
//  ViewController.m
//  TableViewInTableView
//
//  Created by 黄俊煌 on 2017/10/27.
//  Copyright © 2017年 hongsui. All rights reserved.
//

/*
     本demo演示tableView 嵌套 tableView，难点在于计算cell高
     计算行高遇到的坑：
     cell里有一个动态的label，按照demo中的方式计算高度，可能会计算不对。
     原因是label的约束width没有固定，导致系统无法计算出label的最大高度。
     解决方法：
         第一种、固定width的约束
         第二种、设置label的最大宽度：Label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 80;
 */

#define WeakSelf __weak typeof(self) weakSelf = self
// 屏幕宽高
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "CommentVC.h"
#import "CommentTCell.h"
#import "Comment.h"
#import "CommentInputView.h"

@interface CommentVC ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CommentInputView *inputView;
@property (nonatomic, strong) NSMutableArray<Comment *> *comments;
@property (nonatomic, strong) Comment *model;
@property (nonatomic, assign) BOOL isReply;

@end

static CGFloat inputViewHeight = 60;

@implementation CommentVC

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:0 target:self action:@selector(reload)];
    self.view.backgroundColor = [UIColor colorWithRed:0.961  green:0.961  blue:0.961 alpha:1];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.inputView];
    
    [self.tableView registerClass:[CommentTCell class] forCellReuseIdentifier:@"PlanDetailsCommentTCellIdentifier"];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)reload {
    [self.tableView reloadData];
}

- (void)loadData {
    for (int i = 0; i < 1; i++) {
        Comment *comment = [Comment new];
        comment.replyName = @"Mince";
        comment.content = @"如果有一天";
        [self.comments addObject:comment];
    }
    [self.tableView reloadData];
}

/** 评论或回复*/
- (void)commentOrReply {
    NSString *text = self.inputView.textView.text;
    if (text.length < 1) {
        return;
    }
    if (text.length > 100) {
        return;
    }
    if (self.model) { // 回复
        if (self.model.byReplyName.length > 0) { // 回复 回复
            Comment *comment = [Comment new];
            comment.replyName = @"Jone";
            comment.byReplyName = self.model.replyName;
            comment.content = self.inputView.textView.text;
            [self.model.replys addObject:comment];
        }else { // 回复 评论
            Comment *comment = [Comment new];
            comment.replyName = @"Jone";
            comment.byReplyName = self.model.replyName;
            comment.content = self.inputView.textView.text;
            [self.model.replys addObject:comment];
        }
    }else { // 评论
        Comment *comment = [Comment new];
        comment.replyName = @"Jone";
        comment.content = self.inputView.textView.text;
        [self.comments addObject:comment];
    }
    [self.tableView reloadData];
    self.inputView.textView.text = @"";
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    if (endRect.origin.y == ScreenHeight) { // 键盘回收
        [UIView animateWithDuration:0.25 animations:^{
            self.inputView.frame = CGRectMake(0, ScreenHeight-inputViewHeight, ScreenWidth, inputViewHeight);
        }];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.inputView.frame = CGRectMake(0, endRect.origin.y-inputViewHeight, ScreenWidth, inputViewHeight);
        }];
    }
}

#pragma mark - Private Methods


#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        CommentTCell *cell = [CommentTCell cellWithTableView:tableView];
    cell.comment = self.comments[indexPath.row];
    WeakSelf;
    cell.didSelectRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath, Comment *reply) {
        weakSelf.inputView.textView.placeholder = [NSString stringWithFormat:@"回复 %@",reply.replyName];
        weakSelf.isReply = YES;
        weakSelf.model = reply;
        [weakSelf.inputView.textView becomeFirstResponder];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTCell *cell = [CommentTCell cellWithTableView:tableView];
    Comment *comment = self.comments[indexPath.row];
//    if (comment.rowHeight > 0) {
//        return comment.rowHeight;
//    }
    CGFloat height = [cell rowHeightWithComment:comment];
    comment.rowHeight = height;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Comment *comment = self.comments[indexPath.row];
    self.inputView.textView.placeholder = [NSString stringWithFormat:@"回复 %@",comment.replyName];
    
    self.isReply = YES;
    self.model = comment;
    [self.inputView.textView becomeFirstResponder];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (_tableView) return _tableView;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-inputViewHeight)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.961  green:0.961  blue:0.961 alpha:1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    return _tableView;
}

- (CommentInputView *)inputView {
    if (_inputView) return _inputView;
    _inputView = [[CommentInputView alloc] initWithFrame:CGRectMake(0, ScreenHeight-inputViewHeight, ScreenWidth, inputViewHeight)];
    _inputView.backgroundColor = [UIColor whiteColor];
    WeakSelf;
    _inputView.textView.textViewShouldBeginEditingBlock = ^BOOL(UITextView *textView) {
        if (!weakSelf.isReply) {
            weakSelf.model = nil;
        }
        weakSelf.isReply = NO;
        return YES;
    };
    _inputView.textView.textViewShouldEndEditingBlock = ^BOOL(UITextView *textView) {
        weakSelf.isReply = NO;
        weakSelf.inputView.textView.placeholder = @"想写些什么...";
        return YES;
    };
    _inputView.sendBlock = ^{
        [weakSelf commentOrReply];
    };
    return _inputView;
}

- (NSMutableArray *)comments {
    if (_comments) return _comments;
    _comments = [NSMutableArray array];
    return _comments;
}

#pragma mark - Setter


@end

