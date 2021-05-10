# IV
A simple framework for the IV design pattern. The IV pattern is based off of VIPER minus all the fluff and removes potential for baklava code by enforcing strong walls between layers. 

## Example

### Interactor

```swift
import Foundation
import IV

class UsersListInteractor: InteractorProtocol {
    // MARK: - Injected
    var commandEmitter: CommandEmitter<UsersListCommand>?
    
    private var users: [User] = []
    
    func handle(event: UsersListEvent) {
        switch event {
        case .didLoadView:
            fetchUsers()
        }
    }
    
    func fetchUsers() {
        // You can replace this with an async call
        self.users = [
            User(id: UUID(), firstName: "Jim", lastName: "Halpert"),
            User(id: UUID(), firstName: "Pam", lastName: "Beesly"),
            User(id: UUID(), firstName: "Michael", lastName: "Scott"),
            User(id: UUID(), firstName: "Kevin", lastName: "Malone")
        ]
        
        let items = users.map({ SimpleListItem(title: $0.fullName, subtitle: $0.id.uuidString) })
        emit(.showItems(items))
    }
}
```

### View
```swift
import UIKit
import IV

class UsersListView: UITableViewController, ViewProtocol {
    // MARK: - Injected
    var eventEmitter: EventEmitter<UsersListInteractor>?
    
    private let reuseIdentifier = "cell"
    private var items: [SimpleListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        
        let interator = UsersListInteractor()
        link(interator)
        eventEmitter?.emit(.didLoadView)
    }
    
    func handle(command: UsersListCommand) {
        switch command {
        case .showItems(let items):
            self.items = items
            tableView.reloadData()
        }
    }
}

extension UsersListView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        
        return cell
    }
}
```

### Command

```swift
enum UsersListCommand {
    case showItems([SimpleListItem])
}
```

### Event
```swift
enum UsersListEvent {
    case didLoadView
}
```

### View items
```swift
struct SimpleListItem {
    var title: String
    var subtitle: String
}
```

### Testing
```swift
import XCTest
import IV
@testable import IVExample

class VIExampleTests: XCTestCase {
    func testInteractor() {
        let showItemsTriggered = expectation(description: "Show users triggered")
        let view = MockView<UsersListInteractor>()
        let interactor = UsersListInteractor()
        view.configure(with: interactor)
        
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
}
```

## Installation

### SPM

IV is built for SPM! SPM is Apple's dependency managment system and is built into Xcode. It is the best way to manage dependencies for iOS, macOS and catalyst applications. To learn how to use SPM, please visit the SPM page [here](https://swift.org/package-manager/)

## License

IV is released under the MIT license. [See LICENSE](https://github.com/cuba/IV/blob/master/LICENSE) for details
