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
		0 == Day01.countFloor("(())");
		0 == Day01.countFloor("()()");
		3 == Day01.countFloor("(((");
		3 == Day01.countFloor("(()(()(");
		3 == Day01.countFloor("))(((((");
		-1 == Day01.countFloor("())");
		-1 == Day01.countFloor("))(");
		-3 == Day01.countFloor(")))");
		-3 == Day01.countFloor(")())())");
		232 == Day01.countFloor(getData("day01"));
	}
}
