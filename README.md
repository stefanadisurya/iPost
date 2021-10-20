# iPost

![iPost's Logo](https://user-images.githubusercontent.com/64721275/138050824-9007ed9e-d8eb-4449-8837-a4bb1fcdbecb.png)

A simple iOS app to display data from a REST API.

## Fetch data using ConsumeAPI
ConsumeAPI is a reusable function to fetch data for the app. Simply use the ConsumeAPI by typing:
```swift
ConsumeAPI.loadData(from: <API>) { data, response, error in
  // Manipulate data
}
```

Example:
```swift
ConsumeAPI.loadData(from: "https://jsonplaceholder.typicode.com/posts") { data, response, error in
  // Manipulate data
}
```

### Post List
A page to display all post data. Each post contains:
| Contents         | API Query Parameter                                       |
| ---------------- |:---------------------------------------------------------:|
| Post title       | [/posts](https://jsonplaceholder.typicode.com/posts)      |
| Post body        | [/posts](https://jsonplaceholder.typicode.com/posts)      |
| Author's name    | [/users/id](https://jsonplaceholder.typicode.com/users/1) |
| Author's company | [/users/id](https://jsonplaceholder.typicode.com/users/1) |

### Post Detail
A page to display post detail. Each post detail contains:
- Post title
- Post body
- Author's name
- Comments

### User Detail
A page to display user detail. This page contains:
- User name
- User email
- User address
- User company
- User's album

### Photo Detail
A page to display photo from user's album. This page contains:
- Photo title
- Photo (with zoom capability)

## Tech Stack
### UIKit
The main Swift framework used to develop the app ([UITableView](https://developer.apple.com/documentation/uikit/uitableview), [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview), etc.).

### REST API
Data displayed in the app is fetched from [JSONPlaceholder](https://jsonplaceholder.typicode.com/). There are no particular library used to fetch the data to avoid dependencies.
