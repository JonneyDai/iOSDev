//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

//
//func HelloWorld (string s1: String ,toString s2: String ,withJoiner joiner: String = " " ) ->String {
//    return s1 + joiner + s2;
//}
//
//print(HelloWorld(string: "hello", toString: "World", withJoiner: "+"))


//let maxNumberOfLoginAttempt = 10
//var currentLoginAttempt = 0
//
//    maxNumberOfLoginAttempt == 5
//
//var x = 0.0, y = 0.0, z = 0.0


//var welcomeMessage: String = "Hello"

//var welcomeMessage = "Hello";
//welcomeMessage = "Hello222"
//
//
//let 你好 = "你好世界"
//
//print(你好)
//
//print("qingiqng")
//
//var friendNumber = 5
//
//print("The current number of friend is \(friendNumber)")

//let minValue = UInt.min
//
//let maxValue = UInt.max
//
//
//let minIntValue = Int.min
//
//let maxIntValue = Int.max
//
//let FloatValue = 3.14
//
//let addTest = 3 + 0.1415926
//
//let demicNumber = 17
//
//let binNumber = 0b10001
//
//let octalNumber = 0o21
//
//let hexNumber = 0x11
//
//let decDouble = 12.1875
//
//let expDouble = 1.21875e1
//
//let hexDouble = 0xC.3p0
//
//let oneMillion = 1_000_000
//
//let overOneMillion = 1_000_000.000_000_1
//
//let twoThousand: UInt16 = 2_000
//
//let one: UInt8 = 1
//
//let thousandAndOne = twoThousand + UInt16(one)
//
//let three = 3
//
//let pointNumber = 0.14159
//
//let pi = Double(three) + pointNumber
//
//let interPi = Int(pi)

//类型别名
//typealias U8 = UInt8

//var u8u8 = U8.max

//bool值
//let originAreOrigin = true
//
//let originAreOrange = false

//if originAreOrange {
//    print("Mum , taste good!")
//}else{
//    print("Mum , taste bad!")
//}

//let http404 = (404, "Not Found")
//
//let (statusCode, statusMessage) = http404
//print("The status code is \(statusCode)")
//
//print("The status message is \(statusMessage)")
//
//let (justTheStatusCode, _) = http404
//
//print("The status code is \(justTheStatusCode)")
//
//print("the status code is \(http404.0)")
//
//print("the status message is \(http404.1)")
//
//let http200Status = (statusCode: 200, description: "OK")
//
//print("The status code is \(http200Status.statusCode)")
//
//print("The status message is \(http200Status.description)")

//let possibleNumber = "123"
//let convertedNumber: Int? = Int(possibleNumber)
//
//if convertedNumber != nil {
//    print("\(possibleNumber) has an integer value of \(convertedNumber!)")
//}else{
//    print("\(possibleNumber) could not be converted to an integer ")
//}
//
//
//if let actualNumber = Int(possibleNumber) {
//    print("\(possibleNumber) has an integer value of \(actualNumber)")
//}else{
//    print("\(possibleNumber) could not be converted to an integer")
//}
//
//var serverResponseCode: Int? = 404
//
//serverResponseCode = nil
//
//var surveyAnswer: String?

//let possibleString: String? = "An optional string."
//print(possibleString)
//print(possibleString!)
//
//
//let assumedString: String! = "An implicitly unwrappen optional string."
//print(assumedString)
//
//if assumedString != nil {
//    print(assumedString)
//}
//
//if let definiteString = assumedString {
//    print(definiteString)
//}
//
//let age = 3
//assert(age >= 0, "An preson`s age cannot be less than zero")

//基本运算符
//let b = 10
//var a = 5
//a = b
//
//let (x, y) = (1, 2)
//
//1 + 2
//
//let hw = "Hello, " + "world"
//let dog: Character = "d"
//let cow: Character = "c"
//
//
//let dc = String(dog) + String(cow)
//
//let hh = hw + String(dog)
//
//
//9 % 4
//
//-9 % 4
//
//8 % 2.5
//
//var i = 0
//++i
//var a = 0
//let b = ++a
//let c = a++

//let three = 3
//let minusThree = -3
//let plisThree = -minusThree

//
//var a = 1
//a += 2
//
//1==1
//2 != 1
//2 > 1
//2 < 1
//


//let name = "world"
//
//if name == "world"{
//    print("hello, world")
//}else{
//    print("I`m sorry \(name), but I don`t recognize you.")
//}
//
//name == "world" ? 1 : 2

//for index in 1...5 {
//    print("\(index) time 5 is \(index * 5)")
//}
//
//let names = ["Anna", "Alex" ,"Brian", "Jack"]
//let count = names.count
//for i in 0..<count {
//    print("Person \(i + 1) is called \(names[i])")
//    
//}

//
//let allowedEntry = false
//if !allowedEntry {
//    print("Access Denied")
//}
//
//let enteredDoorCode = true
//let passedRetinaScan = false
//if enteredDoorCode && passedRetinaScan {
//    print("Welcome!")
//}else{
//    print("Access Denied")
//}
//
//let hasDoorKey = false
//let knowOverridePassword = true
//if hasDoorKey || knowOverridePassword{
//    print("Welcome!")
//}else{
//    print("Access Denied")
//}
//
//if enteredDoorCode && passedRetinaScan || hasDoorKey || knowOverridePassword {
//    print("Welcome!")
//}else{
//    print("Access Denied")
//}
//

//字符串和字符
//let someString = "Some string literal value"
//
//var emptyString = ""
//var anotherEmptyString = String()
//
//if emptyString.isEmpty{
//    print("Nothing to see here")
//}

//for character in "Dog!".characters{
//    print(character)
//}

//
//let exclamationMark: Character = "!"
//
//let catCharacters: [Character] = ["C","a","t","!"]
//let catString = String(catCharacters)
//
//let string1 = "Hello"
//let string2 = " there"
//
//var welcome = string1 + string2
//
//welcome.append(exclamationMark)
////字符串插值
//let multiplier = 3
//let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
//
////字符串相等
//let quotation = "We`re a lot alike, you and I."
//let sameQuotation = "We`re a lot alike, you and I."
//if quotation == sameQuotation{
//    print("These two strings are considered equal")
//}

//let romeoAndJuliet = ["Act 1 Scene 1: Verona, A public place", "Act 1 Scene 2: Capulet`s mansion", "Act 1 Scene 3: A room in Capulet`s mansion", "Act 1 Scene 4: A street outside Capulet`s mansion", "Act 1 Scene 5: The Great Hall in Capulet`s mansion", "Act 2 Scene 1: Outside Capulet`s mansion", "Act 2 Scene 2: Capulet`s orchard", "Act 2 Scene 3: Outside Friar Lawrence`s cell", "Act 2 Scene 4: A street in Verona", "Act 2 Scene 5: Capulet`s mansion", "Act 2 Scene 6: Friar Lawrence`s cell"]
//var act1SceneCount = 0
//var act2SceneCount = 0
//for scene in romeoAndJuliet {
//    if scene.hasPrefix("Act 1"){
//        ++act1SceneCount
//    }else if scene.hasPrefix("Act 2"){
//        ++act2SceneCount
//    }
//}
//
//print("There are \(act1SceneCount) scenes in Act 1")
//print("There are \(act2SceneCount) scenes in Act 2")
//
//var mansionCount = 0
//var cellCount = 0
//for scene in romeoAndJuliet {
//    if scene.hasSuffix("Capulet`s mansion"){
//        ++mansionCount
//    }else if scene.hasSuffix("Friar Lawrence`s cell"){
//        ++cellCount
//    }
//}
//
//print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
//
//
//字符串大小写
//let normal = "Could you help me, please?"
//let shouty = normal.uppercaseString
//let whispered = normal.lowercaseString
//

//Unicode
//let unusualMenagerie = "Koala, Snail, Penguin, Dromedary"
//print("unusualMenagerier has \(unusualMenagerie.characters.count) characters")
//var word = "cafe"
//print("the number of characters in \(word) is \(word.characters.count)")
//
//word += "\u{301}"
//print("The number of characters in \(word) is \(word.characters.count)")
//
//let greeting = "Guten Tag!"
//greeting.startIndex
//greeting[greeting.startIndex]
//greeting.endIndex.predecessor()
//greeting[greeting.endIndex.predecessor()]
//greeting.startIndex.successor()
//greeting[greeting.startIndex.successor()]
//let index = greeting.startIndex.advancedBy(7)
//greeting[index]
//
//for index in greeting.characters.indices{
//    print("\(greeting[index]) ", terminator: "")
//}
//
//var welcome = "hello"
//welcome.insert("!", atIndex: welcome.endIndex)
//
//welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())
//
//welcome
//
//welcome.removeAtIndex(welcome.endIndex.predecessor())
//
//welcome

//数组类型
//var shoppingList: [String] = ["Eggs","Milk"]
////
//var shoppingList2 = ["dd","cc",1,223,"c","1",2.5]
////
//print("The shopping list contains \(shoppingList.count) items.")
//if shoppingList.isEmpty {
//    print("The shoppong list is empty.")
//}else {
//    print("The shopping list is not empty.")
//}
//
//shoppingList2.appendContentsOf(["aa","qq"])
//shoppingList.append("hello")
//shoppingList2.append("hh")
//
//shoppingList2 += ["aaaaa"]
//
//var firstItem = shoppingList[0]
//
//shoppingList[0] = "SixEggs"
//
//shoppingList
//
//shoppingList[0...1] = ["dd"]
//shoppingList
//
//shoppingList.insert("Maple", atIndex: 0)
//shoppingList.removeAtIndex(0)
//shoppingList
//
//for item in shoppingList{
//    print(item)
//}
//
//for (index, value) in shoppingList.enumerate(){
//    print("Item\(String(index + 1)): \(value)")
//}
//
//
//var someInts = [Int]()
//print("someInts is of type [Int] with \(someInts.count) items.")
//someInts.append(3)
//someInts = []
//
//var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
//
//var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5)
//
//var sixDoubles = threeDoubles + anotherThreeDoubles
//

//集合类型
//var letters = Set<Character>()
//
//print("letters is of type Set<Character> with \(letters.count) items.")
//
//letters.insert("a")
//letters = []
//
//var favoriteGenres: Set<String> = ["Rock" ,"Classical", "Hip hop"]
//
//var favoriteGenres2: Set = ["aa", "bb", "cc"]
//print("I have \(favoriteGenres.count) favorite music genres."
//)
//
//favoriteGenres.insert("dd")
//
//favoriteGenres.remove("Rock")
//
//favoriteGenres.contains("Funk")
//
//for genre in favoriteGenres{
//    print("\(genre)\n")
//}
//
//for genre in favoriteGenres.sort(){
//    print("\(genre)")
//}
//
//let oddDigits: Set = [1,3,5,7,9]
//let evenDigits: Set = [0, 2, 4, 6, 8]
//let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
//oddDigits.union(evenDigits).sort()
//oddDigits.intersect(evenDigits).sort()
//oddDigits.subtract(singleDigitPrimeNumbers).sort()
//oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()
//















