import days.*;
import days.Day21;
import days.Day22;
import days.Day23;
import sys.io.File;
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
		255 == Day05.countNiceStrings(getData("day05"), Day05.isNiceString);

		true == Day05.isNiceString2("qjhvhtzxzqqjkmpb");
		true == Day05.isNiceString2("xxyxx");
		false == Day05.isNiceString2("uurcxstgmygtbstg");
		false == Day05.isNiceString2("ieodomkazucvgmuy");
		55 == Day05.countNiceStrings(getData("day05"), Day05.isNiceString2);
	}

	@Ignored
	function specDay06() {
		543903 == Day06.countLitLights(getData("day06"));
		14687245 == Day06.countLitLights2(getData("day06"));
	}

	function specDay07() {
		var example = getData("day07-0");
		72 == Day07.getSignal(example, "d");
		507 == Day07.getSignal(example, "e");
		492 == Day07.getSignal(example, "f");
		114 == Day07.getSignal(example, "g");
		65412 == Day07.getSignal(example, "h");
		65079 == Day07.getSignal(example, "i");
		123 == Day07.getSignal(example, "x");
		456 == Day07.getSignal(example, "y");

		16076 == Day07.getSignal(getData("day07-1"), "a");
		2797 == Day07.getSignal2(getData("day07-1"));
	}

	function specDay08() {
		12 == Day08.computeDecodingDifference(getData("day08-0"));
		1342 == Day08.computeDecodingDifference(getData("day08-1"));

		19 == Day08.computeEncodingDifference(getData("day08-0"));
		2074 == Day08.computeEncodingDifference(getData("day08-1"));
	}

	@Ignored
	function specDay09() {
		605 == Day09.findRoute(getData("day09-0"), Shortest);
		207 == Day09.findRoute(getData("day09-1"), Shortest);

		982 == Day09.findRoute(getData("day09-0"), Longest);
		804 == Day09.findRoute(getData("day09-1"), Longest);
	}

	@Ignored
	function specDay10() {
		"11" == Day10.lookAndSay("1");
		"21" == Day10.lookAndSay("11");
		"1211" == Day10.lookAndSay("21");
		"111221" == Day10.lookAndSay("1211");
		"312211" == Day10.lookAndSay("111221");

		360154 == Day10.lookAndSay("1113122113", 40).length;
		5103798 == Day10.lookAndSay("1113122113", 50).length;
	}

	@Ignored
	function specDay11() {
		false == Day11.isValidPassword("hijklmmn");
		false == Day11.isValidPassword("abbceffg");
		false == Day11.isValidPassword("abbcegjk");
		true == Day11.isValidPassword("abcddfee");
		"abcdffaa" == Day11.findNextValidPassword("abcdefgh");
		"ghjaabcc" == Day11.findNextValidPassword("ghijklmn");

		"hxbxxyzz" == Day11.findNextValidPassword("hxbxwxba");
		"hxcaabcc" == Day11.findNextValidPassword("hxbxxyzz");
	}

	function specDay12() {
		6 == Day12.sumNumbers('[1,2,3]');
		6 == Day12.sumNumbers('{"a":2,"b":4}');
		3 == Day12.sumNumbers('[[[3]]]');
		3 == Day12.sumNumbers('{"a":{"b":4},"c":-1}');
		0 == Day12.sumNumbers('{"a":[-1,1]}');
		0 == Day12.sumNumbers('[-1,{"a":1}]');
		0 == Day12.sumNumbers('[]');
		0 == Day12.sumNumbers('{}');
		111754 == Day12.sumNumbers(getData("day12"));

		6 == Day12.sumNonRedNumbers('[1,2,3]');
		4 == Day12.sumNonRedNumbers('[1,{"c":"red","b":2},3]');
		0 == Day12.sumNonRedNumbers('{"d":"red","e":[1,2,3,4],"f":5}');
		6 == Day12.sumNonRedNumbers('[1,"red",5]');
		65402 == Day12.sumNonRedNumbers(getData("day12"));
	}

	function specDay13() {
		330 == Day13.findOptimalNetHappiness(getData("day13-0"), false);
		664 == Day13.findOptimalNetHappiness(getData("day13-1"), false);
		640 == Day13.findOptimalNetHappiness(getData("day13-1"), true);
	}

	function specDay14() {
		1120 == Day14.calculateWinningScore(getData("day14-0"), 1000, Old);
		2655 == Day14.calculateWinningScore(getData("day14-1"), 2503, Old);

		689 == Day14.calculateWinningScore(getData("day14-0"), 1000, New);
		1059 == Day14.calculateWinningScore(getData("day14-1"), 2503, New);
	}

	@Ignored
	function specDay15() {
		62842880 == Day15.findHighestScoringCookie(getData("day15-0"));
		18965440 == Day15.findHighestScoringCookie(getData("day15-1"));

		File.saveContent("export/solveDay15.py", Day15.generateSolver(getData("day15-1")));
		Sys.command("python3 export/solveDay15.py"); // 15862900
	}

	function specDay16() {
		var query = [
			"children" => 3, "cats" => 7, "samoyeds" => 2, "pomeranians" => 3, "akitas" => 0, "vizslas" => 0, "goldfish" => 5, "trees" => 3, "cars" => 2,
			"perfumes" => 1,
		];
		40 == Day16.findSueNumber(getData("day16"), query);
		241 == Day16.findRealSueNumber(getData("day16"), query);
	}

	@Ignored
	function specDay17() {
		4 == Day17.countContainerCombinations(getData("day17-0"), 25);
		1304 == Day17.countContainerCombinations(getData("day17-1"), 150);

		3 == Day17.countCombinationsWithLeastContainers(getData("day17-0"), 25);
		18 == Day17.countCombinationsWithLeastContainers(getData("day17-1"), 150);
	}

	@Ignored
	function specDay18() {
		4 == Day18.countLitLights(getData("day18-0"), 4, false);
		814 == Day18.countLitLights(getData("day18-1"), 100, false);

		17 == Day18.countLitLights(getData("day18-0"), 5, true);
		924 == Day18.countLitLights(getData("day18-1"), 100, true);
	}

	function specDay19() {
		4 == Day19.countDistinctMolecules(getData("day19-0"));
		518 == Day19.countDistinctMolecules(getData("day19-1"));

		3 == Day19.findFewestStepsForMedicine(getData("day19-2"));
		200 == Day19.findFewestStepsForMedicine(getData("day19-1"));
	}

	@Ignored
	function specDay20() {
		1 == Day20.findLowestHouseNumber(10);
		4 == Day20.findLowestHouseNumber(70);

		776160 == Day20.findLowestHouseNumber(33100000);
		786240 == Day20.findLowestHouseNumber2(33100000);
	}

	function specDay21() {
		Player == Day21.findWinner({hitPoints: 8, damage: 5, armor: 5}, {hitPoints: 12, damage: 7, armor: 2});

		var boss:Fighter = {hitPoints: 100, damage: 8, armor: 2};
		91 == Day21.findMinimumGoldToWin(getData("day20"), boss);
		158 == Day21.findMaximumGoldToLose(getData("day20"), boss);
	}

	function specDay22() {
		var state = Day22.simulateBattle(10, 250, 13, 8, [Poison, MagicMissile]);
		2 == state.playerHP;
		24 == state.playerMana;
		0 >= state.bossHP;

		var state = Day22.simulateBattle(10, 250, 14, 8, [Recharge, Shield, Drain, Poison, MagicMissile]);
		1 == state.playerHP;
		114 == state.playerMana;
		0 >= state.bossHP;

		1824 == Day22.findMinimumManaToWin(50, 500, 71, 10, false);
		1937 == Day22.findMinimumManaToWin(50, 500, 71, 10, true);
	}

	function specDay23() {
		2 == Day23.execute(getData("day23-0"))[A];
		170 == Day23.execute(getData("day23-1"))[B];
	}
}
