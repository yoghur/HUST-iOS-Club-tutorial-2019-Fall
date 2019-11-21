import UIKit

//MARK: - 函数
//函数是一个独立的代码块，用来执行特定的任务。通过给函数一个名字来定义它的功能，并且在需要的时候，通过这个名字来“调用”函数执行它的任务
//Swift 中的每一个函数都有类型，由函数的形式参数类型和返回类型组成

//下边示例中的函数叫做 greet(person:) ，跟它的功能一致——它接收一个人的名字作为输入然后返回对这个人的问候。要完成它，你需要定义一个输入形式参数——一个叫做 person 的 String类型值——并且返回一个 String 类型，它将会包含对这个人的问候：

//定义和调用函数
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))
print(greet(person: "Brain"))

//简化写法
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))

////函数的形式参数和返回值
////无形式参数的函数
//func sayHelloWorld() -> String {
//    return "hello, world"
//}
//print(sayHelloWorld())
//
////无返回值的函数
//func greeting(person: String) {
//    print("Hello, \(person)!")
//}
//greeting(person: "Dave")
//// Prints "Hello, Dave!"

//多形式参数的函数
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))

//多返回值的函数
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")


//指定实际参数标签
//实际参数标签的使用能够让函数的调用更加明确，更像是自然语句，同时还能提供更可读的函数体并更清晰地表达你的意图。
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Wuhan"))

//可变形式参数
func mean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

mean(1, 2, 3, 4, 5)
mean(3, 5.5, 4.4)



//MARK: - 结构体与类

//结构体：把相关数据块组合在一起放在内存中的一种类型
//声明结构体
struct Town {
    //添加属性
    //人口
    var population = 5_422
    //红路灯数量
    var numberOfStoplights = 4
    
    //添加实例方法
    func printDescription() {
        print("Population: \(population), numberofStoplights: \(myTown.numberOfStoplights)")
    }
    
    mutating func changePopulation(by amount: Int) {
        population += amount
    }
}

//创建Town的实例
var myTown = Town()
//print("Population: \(myTown.population), numberofStoplights: \(myTown.numberOfStoplights)")
//调用实例方法
myTown.printDescription()

//添加人口
myTown.changePopulation(by: 500)
myTown.printDescription()


//类
class Monster {
    var town: Town?
    var name = "Monster"
    
    func terroizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town")
        } else {
            print("\(name) hasn't found a town")
        }
    }
}

let genericMonster = Monster()
genericMonster.town = myTown
genericMonster.terroizeTown()

//MARK: - 属性
//属性可以将值与特定的类、结构体联系起来
//存储属性会存储常量或变量作为实例的一部分，反之计算属性会计算（而不是存储）值

//存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 6

class FixedLengthRangeClass {
    var firstValue: Int = 0
    var length: Int = 0
}
var rangeOfFiveItems = FixedLengthRangeClass()
rangeOfFiveItems.firstValue = 1
rangeOfFiveItems.length = 4

//计算属性
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
class Rect {
    var orgin = Point()
    var size = Size()
//    Rect 为名为 center 的计算变量定义了一个定制的读取器（ getter ）和设置器（ setter ），来允许你使用该长方形的 center ，就好像它是一个真正的存储属性一样。
    var center: Point {
        get {
            let centerX = orgin.x + (size.width / 2)
            let centerY = orgin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            orgin.x = newCenter.x - (size.width / 2)
            orgin.y = newCenter.y - (size.width / 2)
        }
    }
}

var square = Rect()
square.orgin = .init(x: 0.0, y: 0.0)
square.size = Size(width: 10.0, height: 10.0)

let initialSquareCenter = square.center
print("initialSquareCenter: (\(initialSquareCenter.x), \(initialSquareCenter.y))")
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.orgin.x), \(square.orgin.y))")

//设置器和读取器的简写
class CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        //隐式返回
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        //默认名newValue
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//只读计算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

//属性观察者
//属性观察者会观察并对属性值的变化做出回应。每当一个属性的值被设置时，属性观察者都会被调用，即使这个值与该属性当前的值相同。
//willSet 会在该值被存储之前被调用。
//didSet 会在一个新值被存储后被调用。

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896

//StepCounter 类声明了一个 Int 类型的 totalSteps 属性。这是一个包含了 willSet 和 didSet 观察者的储存属性。
//totalSteps 的 willSet 和 didSet 观察者会在每次属性被赋新值的时候调用。就算新值与当前值完全相同也会如此。
//栗子中的 willSet 观察者为增量的新值使用自定义的形式参数名 newTotalSteps ，它只是简单的打印出将要设置的值。
//didSet 观察者在 totalSteps 的值更新后调用。它用旧值对比 totalSteps 的新值。如果总步数增加了，就打印一条信息来表示接收了多少新的步数。 didSet 观察者不会提供自定义的形式参数名给旧值，而是使用 oldValue 这个默认的名字。

//类型属性
//使用 static 关键字来开一类型属性。对于类类型的计算类型属性，你可以使用 class 关键字来允许子类重写父类的实现。
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
    
}

SomeClass.storedTypeProperty = "Another value"
print(SomeClass.storedTypeProperty)
print(SomeClass.computedTypeProperty)

//MARK: - 方法
//实例方法
//实例方法 是属于特定类实例、结构体实例或者枚举实例的函数
//实例方法默认可以访问同类下所有其他实例方法和属性。实例方法只能在类型的具体实例里被调用。它不能在独立于实例而被调用。
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
print(counter.count)
counter.increment()
print(counter.count)
counter.increment(by: 5)
print(counter.count)
counter.reset()
print(counter.count)

//self属性
//每一个类的实例都隐含一个叫做 self的属性，它完完全全与实例本身相等。你可以使用 self属性来在当前实例当中调用它自身的方法。
//self.count += 1

class AnotherPoint {
    var x = 2.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = AnotherPoint()
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

//类型方法
//如上文描述的那样，实例方法是特定类型实例中调用的方法。你同样可以定义在类型本身调用的方法。这类方法被称作类型方法。你可以通过在 func关键字之前使用 static关键字来明确一个类型方法。类同样可以使用 class关键字来允许子类重写父类对类型方法的实现。

class Math {
    class func abs(_ number: Int) -> Int {
        if number < 0 {
            return (-number)
        } else {
            return number
        }
    }
}

let num = Math.abs(-3)
print(num)

//MARK: - 继承
//一个类可以从另一个类继承方法、属性和其他的特性。当一个类从另一个类继承的时候，继承的类就是所谓的子类，而这个类继承的类被称为父类。
//在 Swift 中类可以调用和访问属于它们父类的方法、属性,并且可以提供它们自己重写的方法，属性定义或修改它们的行为
//类也可以向继承的属性添加属性观察器，以便在属性的值改变时得到通知。可以添加任何属性监视到属性中，不管它是被定义为存储还是计算属性。

//定义一个基类:任何不从另一个类继承的类都是所谓的基类。
//Swift 类不会从一个通用基类继承。你没有指定特定父类的类都会以基类的形式创建。

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        //do nothing
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

//Vehicle 类为任意的车辆定义了共同的特征，但是对它本身没有太大用处。为了让它更有用，你需要重定义它来描述更具体的车辆种类。
//子类
//子类是基于现有类创建新类的行为。子类从现有的类继承了一些特征，你可以重新定义它们。你也可以为子类添加新的特征。
class Bicycle: Vehicle {
    var hasBasket = false
}

//新的 Bicycle 类自动获得了 Vehicle 的所有特征，例如它的 currentSpeed 和 description 属性以及 makeNoise() 方法。
//除了继承的特征， Bicycle 类定义了一个新的存储属性 hasBasket ，并且默认值为 false

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print(bicycle.description)
//子类本身也可以被继承。下个栗子创建了一个 Bicycle 的子类，称为”tandem”的两座自行车
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandom: \(tandem.description)")

//重写
//子类可以提供它自己的实例方法、类型方法、实例属性，类型属性或下标脚本的自定义实现，否则它将会从父类继承。这就所谓的重写。
//要重写而不是继承一个特征，你需要在你的重写定义前面加上 override 关键字。这样做说明你打算提供一个重写而不是意外提供了一个相同定义
//当你为子类提供了一个方法、属性或者下标脚本时，有时使用现有的父类实现作为你重写的一部分是很有用的,你可以通过使用 super 前缀访问父类的方法、属性或下标脚本

//重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()

//重写属性
//你可以重写一个继承的实例或类型属性来为你自己的属性提供你自己自定义的 getter 和 setter ，或者添加属性观察器确保当底层属性值改变时来监听重写的属性

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print(car.description)

//重写属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

//阻止重写
//通过在方法、属性或者下标脚本的关键字前写 final 修饰符(比如 final var ， final func ， final class func ， final subscript )。
//你可以通过在类定义中在 class 关键字前面写 final 修饰符( final class )标记一整个类为终点。任何想要从终点类创建子类的行为都会被报告一个编译时错误

//MARK: - 初始化
//初始化是为类、结构体或者枚举准备实例的过程。这个过需要给实例里的每一个存储属性设置一个初始值并且在新实例可以使用之前执行任何其他所必须的配置或初始化。
//你通过定义初始化器来实现这个初始化过程，它更像是一个用来创建特定类型新实例的特殊的方法
//Swift 初始化器不返回值。这些初始化器主要的角色就是确保在第一次使用之前某类型的新实例能够正确初始化。
//类类型的实例同样可以实现一个反初始化器，它会在这个类的实例被释放之前执行任意的自定义清理

//在创建类和结构体的实例时必须为所有的存储属性设置一个合适的初始值。存储属性不能遗留在不确定的状态中。

//为存储属性设置初始化值
class Fahrenheit {
//    var temperature = 32.0 默认的属性值:默认值也让你使用默认初始化器
    var temperature:Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("the default temperature is \(f.temperature) Fahrenheit")

//自定义初始化

//初始化形式参数
class Celsius {
    var temperatureInCelsius: Double
    init(fromFarenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.0
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let boilingWater = Celsius(fromFarenheit: 212.0)
print(boilingWater.temperatureInCelsius)
let freezingWater = Celsius(fromKelvin: 273.15)
print(boilingWater.temperatureInCelsius)
let bodyTemperature = Celsius(37.0)
print(bodyTemperature.temperatureInCelsius)

class Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        self.red = white
        self.green = white
        blue = white
    }
    
}

let magneta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//可选属性类型
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets."


/*:
 # 类与函数的使用
 
 ## 类的使用
 
 > 1. 建立一个Person类，构造三个实例存储属性name, gender, age以及一个类存储属性isSociety。用初始化器init函数对name,gender,age进行初始化，isSocity直接在类中赋值true
 > 2. 创建一个计算属性变量，属性名为description，返回一个字符串，包含name，gender，age的值。(返回结果示例：name:llj, gender:man, age:22)
 > 3. 创建一个实例方法，方法名为printDescription，无参数与返回值。在方法中打印description的值
 > 4. 创建一个该Person类的实例（实例名为person，name就写自己的名字，gender写“man”或“woman”, age填自己名字）,调用printDescription方法。
 > 5. 创建一个Person类的子类Student，构造一个实例变量score并赋值0。为该变量添加一个didSet属性观察者，在其中打印score的新值。（打印格式： my score is  \\(score)）
 > 6. 在Student类中重写description属性，在返回值中拼接score的值。（返回结果示例：name:llj, gender:man, age:22, score:90）
 > 7. 创建一个该Student类的实例(name，gender，age的值同上)，修改实例变量score的值为90，然后调用printDescription方法。
 
 ## 函数的使用
 
 > 1. 将第一次作业中的排序和输出部分写在一个函数体内，函数名为sortArray，输入的形参为int类型数组，无返回值。然后将numArray数组作为参数传入，确保输出结果与第一次作业一致。
 */
















