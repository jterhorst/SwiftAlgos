import UIKit


/**
 Reverse the vowels in a given string.
 e.g., "BinarySearch" = "BanerySairch"
 e.g., "Hello" = "Holle"
 */

/**
 Approach: Add vowel instances to a stack, i.e., last-in, first-out.
 ... Then, add the indecies to a queue, ie, first-in, first-out.

 These structures will reverse the characters while maintaining index ordering.
 */

func reverseVowels(input: String) -> String? {

    guard input.count > 0 else {
        return ""
    }

    var output = input

    let vowels: Set<String> = ["a","e","i","o","u"]
    let vowelStack = Stack<String>()
    let indicesQueue = Queue<Int>()

    var charIndex = 0
    for char in input {
        if vowels.contains(char.lowercased()) {
            vowelStack.push(String(char))
            indicesQueue.enQueue(charIndex)
        }
        charIndex += 1
    }

    while let nextIndex = indicesQueue.deQueue() {
        guard let nextVowel = vowelStack.popValue() else {
            return output // we shouldn't reach this ever, but bail early if we do.
        }

        output = output.replace(nextIndex, nextVowel)
    }

    return output
}

print(reverseVowels(input: "BinarySearch")!)
print(reverseVowels(input: "Hello")!)


extension String {

    //Enables replacement of the character at a specified position within a string
    func replace(_ index: Int, _ newChar: String) -> String {
        var chars = Array(self)
        if let element = newChar.first {
            chars[index] = element
        }
        let modifiedString = String(chars)
        return modifiedString
    }
}


class Node<T> {

   var tvalue: T?
   var next: Node?

    init() {
        //package support
    }
}

class Queue<T> {

    var top = Node<T>()
    private var counter: Int = 0

    var count: Int {
        return counter
    }

    func peek() -> T? {
        return top.tvalue
    }

    //check for a value
    func isEmpty() -> Bool {

        guard top.tvalue != nil else {
            return true
        }

        return false
    }

    func enQueue(_ key: T) {

        guard top.tvalue != nil else {
            top.tvalue = key
            counter += 1
            return
        }

        let childToUse = Node<T>()
        var current = top


        //find next position - O(n)
        while let next = current.next {
            current = next
        }


        //append new item
        childToUse.tvalue = key
        current.next = childToUse
        counter += 1
    }



    //retrieve top level item - O(1)
    func deQueue() -> T? {


        //trivial case
        guard top.tvalue != nil else {
            return nil
        }


        //retrieve current item
        let item = top.tvalue


        //queue next item
        if let next = top.next {
          top = next
          counter -= 1
        }

        else {
          top.tvalue = nil
          counter = 0
        }


        return item

    }



}

class Stack<T> {

   var top: Node<T>
   private var counter: Int = 0


  init() {
        top = Node<T>()
    }

    var values: Array<Node<T>> {

        var results = Array<Node<T>>()

        var current: Node<T>? = top

        while let item = current {
            results.append(item)
            current = item.next
        }

        return results

    }

    //the number of items - O(1)
   var count: Int {
        return counter
    }


    //MARK: Other functions


    //retrieve the top most item - O(1)
    func peek() -> T? {

        if let item = top.tvalue {
            return item
        }
        else {
            return nil
        }
    }



    //check for value - O(1)
    func isEmpty() -> Bool {

        if self.count == 0 {
            return true
        }

        else {
            return false
        }

    }


  //add item to the stack - O(1)
  func push(_ tvalue: T) {


        //return trivial case
        guard top.tvalue != nil else {
            top.tvalue = tvalue
            counter += 1
            return
        }


        //create new item
        let childToUse = Node<T>()
        childToUse.tvalue = tvalue


        //set new created item at top
        childToUse.next = top
        top = childToUse


        //set counter
        counter += 1

    }


//MARK: Pop functions

    //returns item from the stack - O(1)
    func popValue() ->T? {


        guard let results = top.tvalue else {
            counter = 0
            return nil
        }


        //make reassignment
        if let element = top.next {
            top = element
            counter -= 1
        }

        return results

    }



    //remove item from the stack - O(1)
    func pop() {

        if top.tvalue == nil {
            counter = 0
        }

        //make reassignment
        if let element = top.next {
            top = element
            counter -= 1
        }

        else {
            top.tvalue = nil
            counter = 0
        }

    }

}
