# SwiftLeaning

[toc]

## Extensions

1. 扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能。它还拥有不需要访问被扩展类型源代码就能完成扩展的能力（即逆向建模）。**扩展可以给一个类型添加新的功能，但是不能重写已经存在的功能**。
   - 添加计算型实例属性和计算型类属性
   - 定义实例方法和类方法
   - 提供新的构造器
   - 定义下标
   - 定义和使用新的嵌套类型
   - 使已经存在的类型遵循（conform）一个协议
2. 扩展可以添加新的计算属性，但是它们不能添加存储属性，或向现有的属性添加属性观察者。





未看部分：构造器



## Protocols

1. 若是一个类拥有父类，应该将父类名放在遵循的协议名之前，以逗号分隔。
2. 协议**总是用 var 关键字来声明变量属性**，在类型声明后加上 { set get } 来表示属性是可读可写的（实现必须是可读可写），可读属性则用 { get } 来表示（实现可以是只读，也可以是可读可写）。属性可以被实现为计算属性，也可以被实现为存储属性。
3. 协议中可以定义可变参数的方法，和普通方法的定义方式相同。协议中的方法不支持提供默认参数。
4. 定义静态方法和属性可以用 static 修饰，如果是类实现协议，实现可以使用 class 替代 static。
5. 如果协议中定义的实例方法会改变遵循该协议的类型的实例，需要在方法前加 mutating 关键字。结构体和枚举遵循此协议时能够满足改变自身实例的要求（如果枚举或者结构体实现改方法不需要改变自身实例，则可以省去 mutating）。如果是类实现了该方法则不用加 mutating 。
6. 尽管协议本身并未实现任何功能，但是协议可以被当做一个功能完备的类型来使用。1）作为函数、方法或构造器中的参数类型或返回值类型。2）作为常量、变量或属性的类型。3）作为数组、字典或其他容器中的元素类型。
7. 即便无法修改源代码，依然可以通过扩展令已有类型遵循并符合协议。扩展可以为已有类型添加属性、方法、下标以及构造器，因此可以符合协议中的相应要求。
8. 当一个类型已经遵循了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空的扩展来让它采纳该协议。
9. 协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔。
10. 你通过添加 AnyObject  或者 class 关键字到协议的继承列表，就可以限制协议只能被类类型采纳。当协议定义的要求需要遵循协议的类型必须是引用语义而非值语义时，应该采用类类型专属协议。
    protocol SomeClassOnlyProtocol: AnyObject,  {
        // 这里是类专属协议的定义部分
    }
    protocol SomeClassOnlyProtocol: class,  {
        // 这里是类专属协议的定义部分
    }
11. 协议合成（Protocol Composition）用 &符号将多个协议组合起来。例如 `var obj: (SomeProtocol1 & SomeProtocol2)? `。协议合成中还可以包含一个类类型（不可以是结构体或者枚举），用来标明一个需要的父类，例如 `var obj: (SomeProtocol1 & SomeProtocol2 & UIView)` 。
12. 可以使用 is 来检查是否遵循某协议，使用 as 转换到指定的协议类型。检查和转换协议的语法与检查和转换类型是完全一样的。
13. 协议的继承只能在协议声明处进行指定，不能在协议扩展处指定继承自另一个协议。
14. 协议扩展来为遵循协议的类型**提供属性、方法以及下标的默认实现** ，不能提供嵌套类型和构造函数默认实现。
    - 如果遵循协议的类型提供了自己的实现，这些自定义实现将会替代扩展中的默认实现被使用；
    - 通过协议扩展为协议要求提供的默认实现和可选的协议要求不同。虽然在这两种情况下，遵循协议的类型都无需自己实现这些要求，但是通过扩展提供的默认实现可以直接调用，而无需使用可选链式调用。



未看部分：构造器要求，有条件地遵循协议，使用合成实现来采纳协议



## ARC（Automatic Reference Counting）

1. 引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递

2. ARC 会在引用的实例被销毁后自动将其弱引用（weak reference）赋值为 nil。并且因为弱引用需要在运行时允许被赋值为 nil，因此只能被定义为可选类型变量。

3. 当 ARC 设置弱引用为 nil 时，属性观察不会被触发，如果是自己设置为 nil 会触发属性观察器。

4. 无主引用（unowned reference）通常都被期望拥有值。ARC 不会在实例被销毁后将无主引用设为 nil，无主引用在其它实例有相同或者更长的生命周期时使用。可以定义成常量，或者变量，或者可选类型。

5. 使用无主引用，必须确保引用始终指向一个未销毁的实例。如果试图在实例被销毁后访问该实例的无主引用，会触发运行时错误。



## 访问控制（Access Control）

1. 如果类型修饰为 private/fileprivate，类型成员则默认是 fileprivate；如果类型修饰为 internal/public/open，类型成员则默认是 internal。 private修饰的类型也可以在同一个文件中访问。

2. 元组的访问级别将由元组中访问级别最严格的元素类型来决定。

3. 函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定，成员变量的访问级别不能高于成员变量类型访问级别。

4. 如果struct的默认逐一构造器的访问级别是由所有成员属性的最低访问级别决定，因此默认逐一构造器最高访问级别是 internal，如果想是 public 只能手动定义。类的默认构造器同理。

5. 枚举成员的访问级别和枚举类型相同，不能为枚举成员单独指定不同的访问级别。枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。

6. 嵌套类型的访问级别可以参考1，可以把嵌套的类型当作外围类型的一个成员来看。

7. 类：可以继承同一模块中的所有有访问权限的类，也可以继承不同模块中被 open 修饰的类。可以通过重写给所继承类的成员提供更高的访问级别，在同一模块中，你可以在符合当前访问级别的条件下重写任意类成员（方法、属性、构造器、下标等）。在不同模块中，你可以重写类中被 open 修饰的成员。

8. 常量、变量、属性不能拥有比它们的类型更高的访问级别。如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private。

9. 协议的访问级别只能在声明协议时指定，不能为单独的协议成员指定，协议中的每个方法或属性都必须具有和该协议相同的访问级别。如果一个继承自其它协议，那么新协议的访问级别最高只能和被继承协议的访问级别相同。一个类型可以遵循比它级别更低的协议，遵循协议时方法实现的访问级别要大于等于类型和协议中级别最小的那个。协议扩展中的默认实现访问级别不受限制，但是如果访问级别比协议声明访问级别低，由于不能对更高级别暴露，起不到默认实现作用。

10. Extension 的访问级别默认与类型的访问级别一样，可以重新指定扩展的默认访问级别（但不能高于类型的访问级别），如果扩展用来遵守协议，则不能指定访问级别。

11. 泛型类型或泛型函数的访问级别取决于泛型类型或泛型函数本身的访问级别，还需结合类型参数的类型约束的访问级别，根据这些访问级别中的最低访问级别来确定。

12. 类型成员的访问级别可以定义的比类型的访问级别高，但是最高只能起到类型访问级别的作用，比如类型是internal，一个成员函数是public的，那么这个成员函数也不可能被其它模块访问。