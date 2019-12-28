package days;

import Util.Point;
import Util.Direction;
import haxe.ds.HashMap;

class Day18 {
	public static function countLitLights(input:String, steps:Int):Int {
		var grid:HashMap<Point, Light> = Util.parseGrid(input);
		for (_ in 0...steps) {
			var next = new HashMap();
			for (pos => light in grid) {
				var lit = Direction.all.count(dir -> grid[pos + dir] == On);
				next[pos] = switch light {
					case On if (lit == 2 || lit == 3): On;
					case On: Off;
					case Off if (lit == 3): On;
					case Off: Off;
				}
			}
			grid = next;
		}
		return [for (light in grid) if (light == On) light].length;
	}
}

private enum abstract Light(String) from String {
	var On = "#";
	var Off = ".";
}
