import days.*;
import utest.ITest;
import utest.UTest;

class Tests implements ITest {
	static function main() {
		UTest.run([new Tests()]);
	}

	function new() {}

	function getData(name:String):String {
		return sys.io.File.getContent('data/$name.txt').replace("\r", "");
	}

	function specDay01() {
		0 == Day01.walk("(())").finalFloor;
		0 == Day01.walk("()()").finalFloor;
		3 == Day01.walk("(((").finalFloor;
		3 == Day01.walk("(()(()(").finalFloor;
		3 == Day01.walk("))(((((").finalFloor;
		-1 == Day01.walk("())").finalFloor;
		-1 == Day01.walk("))(").finalFloor;
		-3 == Day01.walk(")))").finalFloor;
		-3 == Day01.walk(")())())").finalFloor;
		232 == Day01.walk(getData("day01")).finalFloor;

		1 == Day01.walk(")").basementCharacter;
		5 == Day01.walk("()())").basementCharacter;
		1783 == Day01.walk(getData("day01")).basementCharacter;
	}
}
