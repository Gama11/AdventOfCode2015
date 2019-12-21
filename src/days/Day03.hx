package days;

import Util.Point;
import Util.Direction.*;
import haxe.ds.HashMap;

class Day03 {
	public static function countHousesWithPresents(input:String):Int {
		var pos = new Point(0, 0);
		var map = new HashMap<Point, Bool>();
		map.set(pos, true);
		for (move in input.split("")) {
			pos = pos.add(switch move {
				case "^": Up;
				case "v": Down;
				case "<": Left;
				case ">": Right;
				case _: throw "invalid move";
			});
			map.set(pos, true);
		}
		return [for (_ in map) _].length;
	}
}
