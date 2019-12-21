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
		// -1 == Day01.walk("())").finalFloor;
		// -1 == Day01.walk("))(").finalFloor;
		// -3 == Day01.walk(")))").finalFloor;
		// -3 == Day01.walk(")())())").finalFloor;
		232 == Day01.walk(getData("day01")).finalFloor;

		1 == Day01.walk(")").basementCharacter;
		5 == Day01.walk("()())").basementCharacter;
		1783 == Day01.walk(getData("day01")).basementCharacter;
	}

	function specDay02() {
		58 == Day02.calculateWrappingPaperRequirement("2x3x4");
		43 == Day02.calculateWrappingPaperRequirement("1x1x10");
		1586300 == Day02.calculateWrappingPaperRequirement(getData("day02"));
		
		34 == Day02.calculateRibbonRequirement("2x3x4");
		14 == Day02.calculateRibbonRequirement("1x1x10");
		3737498 == Day02.calculateRibbonRequirement(getData("day02"));
	}

	function specDay03() {
		2 == Day03.countHousesWithPresents(">");
		4 == Day03.countHousesWithPresents("^>v<");
		2 == Day03.countHousesWithPresents("^v^v^v^v^v");
		2565 == Day03.countHousesWithPresents(getData("day03"));

		3 == Day03.countHousesWithPresents2("^v");
		3 == Day03.countHousesWithPresents2("^>v<");
		11 == Day03.countHousesWithPresents2("^v^v^v^v^v");
		2639 == Day03.countHousesWithPresents2(getData("day03"));
	}

	@Ignored
	function specDay04() {
		609043 == Day04.mineAdventCoins("abcdef", 5);
		1048970 == Day04.mineAdventCoins("pqrstuv", 5);
		117946 == Day04.mineAdventCoins("ckczppom", 5);

		3938038 == Day04.mineAdventCoins("ckczppom", 6);
	}

	function specDay05() {
		true == Day05.isNiceString("ugknbfddgicrmopn");
		true == Day05.isNiceString("aaa");
		false == Day05.isNiceString("jchzalrnumimnmhp");
		false == Day05.isNiceString("haegwjzuvuyypxyu");
		false == Day05.isNiceString("dvszwmarrgswjxmb");
		255 == Day05.countNiceStrings(getData("day05"));
	}
}
