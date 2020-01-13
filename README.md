# IV
A simple framework for the IV design pattern

## Example

### Interactor

```swift
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
        
        commandEmitter?.emit(.showUsers(users))
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
    
    // We can replace this with view models
    private let reuseIdentifier = "cell"
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        
        eventEmitter?.emit(.didLoadView)
    }
    
    func handle(command: UsersListCommand) {
        switch command {
        case .showUsers(let users):
            self.users = users
            tableView.reloadData()
        }
    }
}

extension UsersListView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let user = users[indexPath.row]
        cell.textLabel?.text = [user.firstName, user.lastName].joined(separator: " ")
        cell.detailTextLabel?.text = user.id.uuidString
        
        return cell
    }
}
```

### Command

```swift
enum UsersListCommand {
    case showUsers([User])
}
```

### Event
```swift
enum UsersListEvent {
    case didLoadView
}
```

### Test
```swift
import XCTest
import IV
@testable import IVExample

class VIExampleTests: XCTestCase {
    func testInteractor() {
        let showUsersTriggered = expectation(description: "Show users triggered")
        let view = MockView<UsersListInteractor>()
        var interactor = UsersListInteractor()
        view.configure(with: &interactor)
        
        view.emit(.didLoadView) { command in
            switch command {
            case .showUsers:
                showUsersTriggered.fulfill()
            }
        }
        
        wait(for: [
            showUsersTriggered
        ], timeout: 10, enforceOrder: true)
    }
}
```

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate PiuPiu into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "cuba/IV"
```

Run `carthage update` to build the framework and drag the built `PiuPiu.framework` into your Xcode project.

## License

PiuPiu is released under the MIT license. [See LICENSE](https://github.com/cuba/IV/blob/master/LICENSE) for details
