// Generated by Apple Swift version 2.1.1 (swiftlang-700.1.101.15 clang-700.1.81)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreLocation;
@import CoreGraphics;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC4Tine11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * __nullable window;
@property (nonatomic, readonly, copy) NSString * __nonnull cognitoAccountId;
@property (nonatomic, readonly, copy) NSString * __nonnull cognitoIdentityPoolId;
@property (nonatomic, readonly, copy) NSString * __nonnull cognitoUnauthRoleArn;
@property (nonatomic, readonly, copy) NSString * __nonnull cognitoAuthRoleArn;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIImage;
@class CLLocationManager;
@class UIButton;
@class UIImagePickerController;
@class UITextField;
@class NSError;
@class CLLocation;
@class UIImageView;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC4Tine20CameraViewController")
@interface CameraViewController : UIViewController <CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIImage * __nullable image;
@property (nonatomic, strong) CLLocationManager * __null_unspecified locationManager;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified shedMessageTextField;
@property (nonatomic, weak) IBOutlet UIImageView * __null_unspecified shedImageView;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewDidLoad;
- (IBAction)postButtonTapped:(UIButton * __nonnull)sender;
- (void)displayCamera;
- (void)imagePickerController:(UIImagePickerController * __nonnull)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> * __nonnull)info;
- (BOOL)textFieldShouldReturn:(UITextField * __nonnull)textField;
- (void)locationManager:(CLLocationManager * __nonnull)manager didFailWithError:(NSError * __nonnull)error;
- (void)locationManager:(CLLocationManager * __nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * __nonnull)locations;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class ProfileViewController;

SWIFT_CLASS("_TtC4Tine23ImageCollectionViewCell")
@interface ImageCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) ProfileViewController * __nullable delegate;
@property (nonatomic, weak) IBOutlet UIImageView * __null_unspecified shedImage;
- (void)awakeFromNib;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC4Tine13ImageUitilies")
@interface ImageUitilies : NSObject
+ (UIImage * __nonnull)cropToSquareWithImage:(UIImage * __nonnull)originalImage;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableView;
@class NSIndexPath;
@class UITableViewCell;

SWIFT_CLASS("_TtC4Tine25LeaderboardViewController")
@interface LeaderboardViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView * __null_unspecified tableView;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UICollectionView;
@class UILabel;
@class UICollectionViewFlowLayout;

SWIFT_CLASS("_TtC4Tine21ProfileViewController")
@interface ProfileViewController : UIViewController <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, readonly) CGFloat kMargin;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified followButton;
@property (nonatomic, weak) IBOutlet UICollectionView * __null_unspecified collectionView;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified usernameLabel;
@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout * __null_unspecified flowLayout;
@property (nonatomic, readonly) BOOL isFollowing;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (UICollectionViewCell * __nonnull)collectionView:(UICollectionView * __nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (NSInteger)collectionView:(UICollectionView * __nonnull)collectionView numberOfItemsInSection:(NSInteger)section;
- (IBAction)followButtonTapped:(UIButton * __nonnull)sender;
- (void)updateWithIdentifier:(NSString * __nonnull)identifier;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UICollectionViewLayout;

@interface ProfileViewController (SWIFT_EXTENSION(Tine)) <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView * __nonnull)collectionView layout:(UICollectionViewLayout * __nonnull)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * __nonnull)indexPath;
@end


SWIFT_CLASS("_TtC4Tine32SearchResultsTableViewController")
@interface SearchResultsTableViewController : UITableViewController
- (void)viewDidLoad;
- (NSInteger)numberOfSectionsInTableView:(UITableView * __nonnull)tableView;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)tableView:(UITableView * __nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UISearchController;
@class UISegmentedControl;
@class UIStoryboardSegue;

SWIFT_CLASS("_TtC4Tine25SearchTableViewController")
@interface SearchTableViewController : UITableViewController <UISearchResultsUpdating>
@property (nonatomic, strong) UISearchController * __null_unspecified searchController;
@property (nonatomic, weak) IBOutlet UISegmentedControl * __null_unspecified segmentedControl;
- (void)viewDidLoad;
- (NSInteger)numberOfSectionsInTableView:(UITableView * __nonnull)tableView;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (void)updateViewBasedOnMode;
- (void)setUpSearchController;
- (void)updateSearchResultsForSearchController:(UISearchController * __nonnull)searchController;
- (IBAction)segmentedControllerChanged:(UISegmentedControl * __nonnull)sender;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class TinelineViewController;

SWIFT_CLASS("_TtC4Tine17ShedTableViewCell")
@interface ShedTableViewCell : UITableViewCell
@property (nonatomic, strong) TinelineViewController * __nullable delegate;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified usernameTextField;
@property (nonatomic, weak) IBOutlet UIImageView * __null_unspecified shedImageView;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified reportButton;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified shareButton;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified likeShedButton;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified usernameSmallButton;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified shedTextLabel;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)prepareForReuse;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * __nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIRefreshControl;

SWIFT_CLASS("_TtC4Tine22TinelineViewController")
@interface TinelineViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, CLLocationManagerDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray<NSString *> * __nonnull shedIDs;
@property (nonatomic, strong) CLLocationManager * __null_unspecified locationManager;
@property (nonatomic, weak) IBOutlet UISegmentedControl * __null_unspecified segmentedController;
@property (nonatomic, weak) IBOutlet UITableView * __null_unspecified tableView;
- (void)viewDidLoad;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (void)refresh:(UIRefreshControl * __nonnull)refreshControl;
- (void)newShedsAddedRefresh;
- (void)locationManager:(CLLocationManager * __nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * __nonnull)locations;
- (void)prepareForSegue:(UIStoryboardSegue * __nonnull)segue sender:(id __nullable)sender;
- (void)locationManager:(CLLocationManager * __nonnull)manager didFailWithError:(NSError * __nonnull)error;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface UIColor (SWIFT_EXTENSION(Tine))
+ (UIColor * __nonnull)rustyTruckGreen;
+ (UIColor * __nonnull)desertFloorTan;
+ (UIColor * __nonnull)desertSkyBlue;
+ (UIColor * __nonnull)hunterOrange;
@end


@interface UIImageView (SWIFT_EXTENSION(Tine))
- (void)downloadImageFromLink:(NSString * __nonnull)link contentMode:(UIViewContentMode)contentMode;
@end


SWIFT_CLASS("_TtC4Tine19logInViewController")
@interface logInViewController : UIViewController
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified emailTextField;
@property (nonatomic, weak) IBOutlet UITextField * __null_unspecified passwordTextField;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (IBAction)signUpTapped:(UIButton * __nonnull)sender;
- (IBAction)signInTapped:(UIButton * __nonnull)sender;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
