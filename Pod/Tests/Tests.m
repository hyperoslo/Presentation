@import UIKit;
@import XCTest;

@interface PodTests : XCTestCase

@end

@implementation PodTests

- (void)testPassingExample
{
    NSArray *array;
    XCTAssertNil(array);
}

- (void)testFailingExample
{
    NSArray *array;
    XCTAssertNotNil(array);
}

@end
