import XCTest
@testable import IV

final class IVTests: XCTestCase {
    func testEmittersFullCycle() {
        let showItemsTriggered = expectation(description: "Show users triggered")
        let view = MockView<MockInteractor>()
        let interactor = MockInteractor()
        view.link(interactor)
        
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
    
    func testRetainCycles() {
        var view: MockView<MockInteractor>? = MockView<MockInteractor>()
        let interactor: MockInteractor? = MockInteractor()
        view?.link(interactor!)
        weak var weakInteractor = interactor
        interactor = nil
        
        // Ensure that reference is still held by view even though we nullified the original var
        XCTAssertNil(interactor)
        XCTAssertNotNil(weakInteractor)
        
        // Ensure that the reference is no longer held when view nullified
        view = nil
        XCTAssertNil(weakInteractor)
    }

    static var allTests = [
        ("testEmittersFullCycle", testEmittersFullCycle),
        ("testRetainCycles", testRetainCycles),
    ]
}
