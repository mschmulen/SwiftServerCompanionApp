import XCTest
@testable import yachtsCommon

class YachtModelsTests: XCTestCase {
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual(YachtModels().text, "Hello, World!")
  }

  func testSerialize() {

    let dictionary:Dictionary<String, Any> = [
      "name":"boat",
      "url":"http://www.url.com",
      "architect":"john",
      "id":123
    ]

    let model = Yacht.deserialize(dictionary: dictionary)
    XCTAssertEqual(model.name, "boat")

  }

  static var allTests : [(String, (YachtModelsTests) -> () throws -> Void)] {
    return [
      ("testExample", testExample),
      ("testSerialize", testSerialize)
    ]
  }
}
