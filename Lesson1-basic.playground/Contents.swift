import UIKit

var str = "Hello, playground"

let myConstant = 49
var myVariable = 42


var x = 0.0, y = 0.0, z = 0.0

var a = 2

var welcomeMessage: String
welcomeMessage = "Hello"

let numConstant: Int
numConstant = 10

var red, green, blue: Double

var friendlyWelome = "Hello!"
friendlyWelome = "Hello!!!"

var languageName = "Swift"
languageName = "Swift++"

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70


let life = 42
let pi = 3.14159
let anotherPi = 3 + 0.14159

/*
print(life)
print(pi)
print("the current value is : \(friendlyWelome)")
*/

//35893534857
/*
 123131313
 454545
 */

let two = 2
let pointTwoSeven = 0.77

let e = Double(two) + pointTwoSeven
let integerE = Int(e)

let orangeAreOrange: Bool = true
let applesAreDelcious = false

var mustNumber: Int? = 344

var a1 = 5 + 6
var a2 = 5 - 3
var a3 = 3 * 5
var a4 = 10.0 / 3
var a5 = 10 / 3
var a6 = 9 % 4

let three = 3
let minusThree = -three

var b = 1
b += 2

1 == 1
1 != 1
1 > 1
1 >= 1
1 <= 1

var stringA = "Hello World!"
print(stringA)

var stringB = String("hello world")
print(stringB)

var stringC = ""
let stringD = String()

stringB.isEmpty

var changeString = "cc"
changeString += " a and b"

var numA = 20
var numB = 5
var strA = "\(numA) * \(numB) = \(numA * numB)"
print(strA)

changeString.count
changeString.isEmpty

let char1: Character = "A"
var char2: Character = "B"
let char3 = "C"

let someInts = [Int]()
let someDoubles = Array<Double>()

var fiveZeros = [0, 0, 0, 0, 0]
var tenZeros = [Int](repeating: 0, count: 10)
print(tenZeros)

var shoppingList: [String] = ["eggs", "milk", "apple", "pear"]
var anotherShoppingList = ["apples", "orange"]

var firstItem = shoppingList[0]

shoppingList.append("orange")
print(shoppingList)
shoppingList += ["banana","peach"]
print(shoppingList)
print(shoppingList + anotherShoppingList)

shoppingList[1] = "juice"
print(shoppingList)

shoppingList.insert("peach", at: 0)
print(shoppingList)

shoppingList.remove(at: 0)
print(shoppingList)

shoppingList.count
shoppingList.isEmpty

shoppingList = []
print(shoppingList)

var someDict = [Int: String]()
var anotherDict = Dictionary<Int, String>()

var someNumbers: [Int: String] = [1: "One", 2: "Two", 3: "Three"]
print(someNumbers)

var google = ["name": "Google", "url": "www.google.com"]
print(google)

google["url"]
google["url"] = "google.com"
print(google)
google["prefix"] = "www"
print(google)
google["prefix"] = nil
print(google)

google.count
google.isEmpty

for ch in "baidu" {
    print(ch)
}
let names = ["Anna", "Alex", "Jack"]
for name in names {
    print(name)
}

let myDict = ["name": "baidu", "url":"www.baidu.com"]
for (key, value) in myDict {
    print("key: \(key), value: \(value)")
}
for key in myDict.keys {
    print(key)
}

for value in myDict.values {
    print(value)
}

for index in 1...5 {
    print("indx: \(index)")
}

var index = 20
while index < 25 {
    index += 1
}

if index < 15 {
    print("<15")
} else {
    print(">=15")
}
//
if index < 10 {
    print("<10")
} else if (index < 15) {
    print("<15")
} else {
    print(">15")
}
































