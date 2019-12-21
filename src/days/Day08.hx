package days;

class Day08 {
	public static function computeDecodingDifference(input:String):Int {
		function memoryLength(s:String):Int {
			return ~/(\\\\|\\"|\\x[0-9a-f][0-9a-f])/g.replace(s, " ").length - 2;
		}
		var strings = input.split("\n");
		return strings.map(s -> s.length).sum() - strings.map(memoryLength).sum();
	}

	public static function computeEncodingDifference(input:String):Int {
		function encodedLength(s:String):Int {
			return s.replace("\\", "\\\\").replace('"', '\\"').length + 2;
		}
		var strings = input.split("\n");
		return strings.map(encodedLength).sum() - strings.map(s -> s.length).sum();
	}
}
