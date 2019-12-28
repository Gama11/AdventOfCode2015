package days;

class Day17 {
	public static function countContainerCombinations(input:String, target:Int):Int {
		var sizes = input.split("\n").map(Std.parseInt);
		var combinations = new Map<String, Bool>();
		var explored = new Map<String, Bool>();
		function search(picked:Array<Int>, leftover:Array<Int>) {
			leftover.sort((a, b) -> a - b);
			picked.sort((a, b) -> a - b);
			var hash = '$picked $leftover';
			if (explored.exists(hash)) {
				return;
			}
			explored[hash] = true;
			var sum = picked.map(i -> sizes[i]).sum();
			if (sum == target) {
				combinations[picked.toString()] = true;
			} else if (sum < target) {
				for (i in leftover) {
					var leftover = leftover.copy();
					leftover.remove(i);
					search(picked.concat([i]), leftover);
				}
			}
		}
		search([], [for (i in 0...sizes.length) i]);
		return [for (_ in combinations) _].length;
	}
}
