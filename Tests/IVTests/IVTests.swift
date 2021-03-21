import XCTest
@testable import IV

final class IVTests: XCTestCase {
    func testInteractor() {
        let showItemsTriggered = expectation(description: "Show users triggered")
        let view = MockView<UsersListInteractor>()
        var interactor = UsersListInteractor()
        view.link(&interactor)
        
        view.emit(.didLoadView) { command in
            switch command {
            case .showItems:
                showItemsTriggered.fulfill()
            }
        }
        
        wait(for: [
            showItemsTriggered
        ], timeout: 10, enforceOrder: true)
    }

    static var allTests = [
        ("testInteractor", testInteractor),
    ]
}
