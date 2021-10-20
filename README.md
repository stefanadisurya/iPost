# iPost

![Platform](https://img.shields.io/cocoapods/p/ios)
![Last commit](https://img.shields.io/github/last-commit/stefanadisurya/iPost)

iPost is a simple iOS app to display data from REST API.

![App Banner](https://user-images.githubusercontent.com/64721275/138067183-6ff52858-16f5-4f01-92aa-5a9ab1e01a1a.png)

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
<br />

## Pages
### Post List
| Contents         | Source                                                          |
| ---------------- | --------------------------------------------------------------- |
| Post title       | [/posts](https://jsonplaceholder.typicode.com/posts)            |
| Post body        | [/posts](https://jsonplaceholder.typicode.com/posts)            |
| Author's name    | [/users/`userId`](https://jsonplaceholder.typicode.com/users/1) |
| Author's company | [/users/`userId`](https://jsonplaceholder.typicode.com/users/1) |

> `userId` should filled with the desired User ID.
<br/>

### Post Detail
| Contents         | Source                                                                             |
| ---------------- | ---------------------------------------------------------------------------------- |
| Post title       | [/posts](https://jsonplaceholder.typicode.com/posts)                               |
| Post body        | [/posts](https://jsonplaceholder.typicode.com/posts)                               |
| Author's name    | [/users/`userId`](https://jsonplaceholder.typicode.com/users/1)                    |
| Comments         | [/posts/`postId`/comments](https://jsonplaceholder.typicode.com/posts/1/comments)  |

> `userId` and `postId` should filled with the desired User ID and Post ID.
<br/>

### User Detail
| Contents         | Source                                                                             |
| ---------------- | ---------------------------------------------------------------------------------- |
| User name        | [/users/`userId`](https://jsonplaceholder.typicode.com/users/1)                    |
| User email       | [/users/`userId`](https://jsonplaceholder.typicode.com/users/1)                    |
| User address     | [/users/`userId`](https://jsonplaceholder.typicode.com/users/1)                    |
| User's album     | [/albums?userId=`userId`](https://jsonplaceholder.typicode.com/albums?userId=1)    |

> `userId` should filled with the desired User ID.
<br/>

### Photo Detail
| Contents         | Source                                                                                             |
| ---------------- | -------------------------------------------------------------------------------------------------- |
| Photo title      | [/albums/`albumId`/photos?id=`photoId`](https://jsonplaceholder.typicode.com/albums/1/photos?id=1) |
| Photo            | [/albums/`albumId`/photos?id=`photoId`](https://jsonplaceholder.typicode.com/albums/1/photos?id=1) |

> `albumId` and `photoId` should filled with the desired Album ID and Photo ID.
<br/>

## Tech Stack
### UIKit
The main Swift framework used to develop the app ([UITableView](https://developer.apple.com/documentation/uikit/uitableview), [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview), etc.).

### REST API
Data displayed in the app is fetched from [JSONPlaceholder](https://jsonplaceholder.typicode.com/). There are no particular library used to fetch the data to avoid dependencies.
