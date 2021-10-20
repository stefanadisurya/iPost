# iPost

![iPost's Logo](https://user-images.githubusercontent.com/64721275/138050824-9007ed9e-d8eb-4449-8837-a4bb1fcdbecb.png)

A simple iOS app to display data from a REST API.

## Pages
### Post List
A page to display all post data. Each post contains:
- Post title
- Post body
- Author's name
- Author's company

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
