import Foundation

/*:
 
 How would we design this model?
 
 * What data structure would we use to track and identify neighboring vertices?
 * What traversal or memoization techniques would we use?
 
*/


class Connection {
    
    var target: Person

    init(_ target: Person) {
        self.target = target
    }
}

class Person: Hashable, Equatable {
    
    let uuid: UUID = UUID()
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    var connections: [Connection] = []
    var name: String
    var hashValue: Int {
        var hasher = Hasher()
        hasher.combine(self.uuid)
        return hasher.finalize()
    }

    init(_ name: String, friends:[Person]) {
        self.name = name
        for buddy in friends {
            connections.append(Connection(buddy))
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
    
    func addConnection(person: Person) {
        connections.append(Connection(person))
    }
}



func findSharedConnections(person: Person) -> [Person] {
    guard person.connections.count > 0 else {
        return []
    }

    var allConnectionCounts: [Person:Int] = [:]

    for c in person.connections {
        for relatedConnection in c.target.connections {
            if relatedConnection.target != person {
                allConnectionCounts[relatedConnection.target, default: 0] += 1
            }
        }
    }
    
    var recommendedConnections:[Person] = []
    
    for (person, count) in allConnectionCounts {
        if count > 1 {
            recommendedConnections.append(person)
        }
    }

    return recommendedConnections
}

let friendG = Person("G", friends: [])
let friendF = Person("F", friends: [])
let friendA = Person("A", friends: [])
let friendD = Person("D", friends: [])
let friendC = Person("C", friends: [friendG, friendF, friendD, friendA])
let friendE = Person("E", friends: [friendC])
let friendB = Person("B", friends: [friendA, friendD])
friendA.addConnection(person: friendC)
friendA.addConnection(person: friendB)
friendD.addConnection(person: friendC)
friendD.addConnection(person: friendB)

let suggestions = findSharedConnections(person: friendA)
assert(suggestions.contains(friendD))
assert(suggestions.count == 1)
print("found \(suggestions.count) suggested friends")

for person in suggestions {
    print("here's another suggested friend!... \(person.name)")
}
