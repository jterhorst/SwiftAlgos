import UIKit

/**
 Your manager at FB would like you to create a new algo to create potential connections between users with shared friends in common.
 How would we design this model?

 What data structure would we use to track and identify neighboring vertices?
 What traversal or memoization techniques would we use?
 */

class Connection {
    var target: Person

    init(_ target: Person) {
        self.target = target
    }
}

class Person {
    var connections: [Connection] = []
    var name: String

    init(_ name: String, friends:[Person]) {
        self.name = name
        for buddy in friends {
            connections.append(Connection(buddy))
        }
    }
}



func findSharedConnections(person: Person) -> [Person] {
    guard person.connections.count > 0 else {
        return []
    }

    

    var possibleConnections:[Person] = []



    return possibleConnections
}


