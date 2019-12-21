package days;

class Day08 {
	public static function computeCodeMemoryDifference(input:String):Int {
		function memoryLength(s:String):Int {
			return ~/(\\\\|\\"|\\x[0-9a-f][0-9a-f])/g.replace(s, " ").length - 2;
		}
		var strings = input.split("\n");
		return strings.map(s -> s.length).sum() - strings.map(memoryLength).sum();
	}
}
