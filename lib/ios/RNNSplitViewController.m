#import "RNNSplitViewController.h"

@implementation RNNSplitViewController

- (instancetype)initWithLayoutInfo:(RNNLayoutInfo *)layoutInfo childViewControllers:(NSArray *)childViewControllers options:(RNNNavigationOptions *)options presenter:(RNNBasePresenter *)presenter {
	self = [super init];
	
	self.presenter = presenter;
	[self.presenter bindViewController:self];
	
	self.options = options;
	self.layoutInfo = layoutInfo;
	
	self.navigationController.delegate = self;
	
	[self bindChildViewControllers:childViewControllers];
	
	return self;
}

- (void)bindChildViewControllers:(NSArray<UIViewController<RNNLayoutProtocol> *> *)viewControllers {
	[self setViewControllers:viewControllers];
	UIViewController<UISplitViewControllerDelegate>* masterViewController = viewControllers[0];
	self.delegate = masterViewController;
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self.options applyOn:self];
}

- (UIViewController *)getLeafViewController {
	return self;
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
	[_presenter present:self.options];
}


@end
