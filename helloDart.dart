

// 메인 컨셉 이해하기

// 1. 변수로 배치할수 있는 모든 것은 객체 취급

// void main() {
//   int number = 42;
//   var isEven = number.isEven;
//   var tmp = null;
//   var string = tmp.toString();
// }


// 함수를 1급함수로 취급
void func(){
  print("1급함수");
}

void firstFunc(Function aFunc){
  aFunc();
}

// void main() {
//   firstFunc(func);
// }

// 정적타입언어로서 타입 추론가능(컴파일시점에 타입검사를 하는 java 9 var 와 동일)


// 2. Null safety

class NullSafe {
  int a = 1;
}

// void main() {
//   // 1. 기본은 Non-Nullable
//   NullSafe a = null;
//   // 2. nullable => ?
//   NullSafe? b = null;
// }


// 3. 최상위 조상은 Object

class Ancestor{
  void hello(Object o){
    if(o is bool) print("불린");
    if(o is int) print("숫자");
  }
}

// void main() {
//   var ancestor = Ancestor();
//   ancestor.hello(true);
//   ancestor.hello(5);
// }

//  4. generic 가능

class Gen<T>{
  void hello(T a){
    print(T.toString() + " 제네릭 지원");
  }
}

// void main() {
//   var intGen = Gen<int>();
//   intGen.hello(5);
//   // intGen.hello("d");
//   var stringGen = Gen<String>();
//   stringGen.hello("a");
// }


// 5. 자바와 달리 접근제한자가 없고 대신 이름앞에 ‘_’ 가 붙으면 private의 개념


// void main() {
//   int _a = 3; // private '_'를 이름앞에 붙임
//   int a = 3; // public
// }

// 6. 자바처럼 표현식과 명령문 둘다 존재



// 7. 특이 키워드만 정리
// 7-1 show // hide

// Import only foo. 함수단위 import 가 가능!
// import 'package:lib1/lib1.dart' show foo;

// Import all names EXCEPT foo.
// import 'package:lib2/lib2.dart' hide foo;


// 7-2 as
// 타입 변경시 사용

class AsTest{
  @override
  String toString() {
    return 'super';
  }
}

// class AsTest2 extends AsTest{
//
//   void asAs(){
//     print("object");
//   }
//
//   @override
//   String toString() {
//     return 'sub';
//   }
// }
//
// void main() {
//   AsTest asTest = AsTest();
//   AsTest2 asTest2 = AsTest2();
//   print(asTest);
//   print(asTest2);
//   var asTest3 = (asTest2 as AsTest);
//   print(asTest3);
// }


// 7-3 assert
// 기본적인 검증 구문

// void main() {
//   var text = null;
//   assert(text != null); // exception!
// }

// 7-4 동기 처리 코드 async await

// Future<void> checkVersion() async {
//   var version = await lookUpVersion();
//   // Do something with version
// }

// 7-5 late
// 지연 초기화 명시

// String a; 선언 불가
// late String a; 선언 가능

// 7-6 메서드 동기화처리시 sync(자바 syncronize)

// 7-7 factory 생성자
// 복잡한 생성 로직을 캡슐화하는 방식으로 보임
// 싱글턴으로 리턴하거나, 복잡한 생성로직을 내부로 감출때 쓰는 키워드?

// class Book {
//   String title;
//   String content;
//   Book(this.title, this.content);
// }
//
// class ComicBook extends Book {
//   ComicBook(String title, String content) : super(title, content);
// }
//
// class ArtBook extends Book {
//   ArtBook(String title, String content) : super(title, content);
// }
//
// void main() {
//   var isComic = true;
//   Book book;
//   if (isComic) {
//     book = new ComicBook("만화책", "만화책이래");
//   }
//   else {
//     book = new ArtBook("그림책", "그림책이래");
//   }
//   print("${book.title} + ${book.content}");
// }

class Book {
  String title;
  String content;
  Book(this.title, this.content);

  factory Book.createBook({required String title, required String content, required bool isComic}){
    if(isComic){
      return ComicBook(title, content);
    }
    else {
      return ArtBook(title, content);
    }
  }
}

class ComicBook extends Book {
  ComicBook(String title, String content) : super(title, content);
}

class ArtBook extends Book {
  ArtBook(String title, String content) : super(title, content);
}

// void main() {
//   var isComic = true;
//   Book book = Book.createBook(title: "만화책이래", content: "만화책이래용", isComic: true);
//   Book book2 = Book.createBook(title: "그림책이래", content: "그림책이래용", isComic: false);
//   print("${book.title} + ${book.content}");
//   print("${book2.title} + ${book2.content}");
// }

// static factory method 패턴을 문법적으로 좀더 정형화한 느낌?


// 7-8 mixin - with
// interface 와 class 상속 사이의 무언가
//
// - 메소드가 구현되어 있어 바로 사용할 수 있다.
// - 다중 상속이 가능하다.
// 자바의 default 메서드를 가진 다중상속 가능 interface 개념?

// 7-9  const vs final
// 컴파일시점에 상수가 되는지, 런타임 시점에 상수가 되는지의 차이 !
// const 는 컴파일시점에 상수가 되지만, final 은 런타임 시점에 상수가 됨

// void main() {
//   const DateTime rightNow = DateTime.now(); // 불가능
//
//   final DateTime rightNow2 = DateTime.now();
// }

//DateTime.now() 는 런타임 시점의 시각을 추출하는 메서드인데, const로 변수를 선언하면 컴파일시점에 값이 바인딩되어야하므로, 값을 바인딩하지 못해 초기화 불가능
// 성능상 const가 컴파일시점에 값을 박아넣으므로 조금더 나음

// 7-10 Typedefs
// 임시 타입변명 짓기?

// typedef IntList = List<int>;
//
// void main() {
//   List<int> list = <int>[];
//   IntList list2 = <int>[];
//   Type type = List<int>;
//   Type type2 = IntList;
//   assert(type == type2); // true
// }

// 7-11 covariant

// 오버라이딩시 하위타입을 기입 가능하게 해줌?
//
// class Animal{
//   void bark(Animal animal){
//     print("$animal 짖기");
//   }
// }
//
// class Bird extends Animal{
//   @override
//   void bark(covariant Bird bird){
//     print("$bird 삐약삐약");
//   }
// }
//
// void main() {
//   var animal = Animal();
//   var bird = Bird();
//   animal.bark(animal);
//   animal.bark(bird);
//   bird.bark(bird);
// }


// 7-12 get set
// private 프로퍼티에 한에 생성가능

class Phone {
  String _body;
  String _number;

  Phone(this._body, this._number);

  String get number => _number;
  String get body => _body;

  set number(String value) {
    _number = value;
  }
  set body(String value) {
    _body = value;
  }
}

// 7-13 dynamic
// 어떤 타입이나 받을수 있는 동적 타입

// void main(){
//   dynamic dynamicType = 6;
//   print(dynamicType);
//   dynamicType = "바뀐대 ㅎㄸ";
//   print(dynamicType);
//   dynamicType = true;
//   print(dynamicType);
// }


// 8. 빌트인 타입들
// Numbers (int, double)
// Strings (String)
// Booleans (bool)
// Lists (List, also known as arrays)
// Sets (Set)
// Maps (Map)
// Runes (Runes; often replaced by the characters API)
// Symbols (Symbol)
// The value null (Null)

// 8-1. Runes
//  빌트인으로 UTF-32 코드, 특문과 이모지까지 나타낼 수 있다.
// import 'package:characters/characters.dart';
// void main(){
//   var smile = "\u{1f600}";
//   var smile2 = '😆';
//   print(smile);
//   print(smile2);
// }

// 8-2 symbol
// 연산자나 식별자선언?

// 9. 함수
// - 1급 함수
void shortHand() => print("와! 람다");

// - named parameter?
// 파라미터를 {} 로 한번더 감싸기
// required 키워드로 강제 가능

void named( {required String? name1, required String? name2} ){
  print("$name1 + $name2");
}

// - optional parameter?
// 파라미터를 [] 로 감싸기

void optional(String op1,[String? op2]){
  print("$op1, + $op2");
}

// - defult parameter?
// {} 파라미터 안에 값 집어 넣기

void defaultParam({String defaul = "default", required String? normal} ){
  print("$defaul + $normal");
}

void main(){
  // named("sdf","sdf"); // 네임드 파라미터는 이렇게 안됨
  named(name1: 'sdf', name2: 'wef');
  optional("df");
  optional("df","sdf");
  defaultParam(defaul: "temp", normal: "노말");
  defaultParam(normal: "노말");
}







