package days;

import Util.Point;
import Util.Direction;
import Util.Direction.*;
import haxe.ds.HashMap;

class Day03 {
	static function parse(input:String):Array<Direction> {
		return input.split("").map(move -> switch move {
			case "^": Up;
			case "v": Down;
			case "<": Left;
			case ">": Right;
			case _: throw "invalid move";
		});
	}

	public static function countHousesWithPresents(input:String):Int {
		var pos = new Point(0, 0);
		var map = new HashMap<Point, Bool>();
		map.set(pos, true);
		for (dir in parse(input)) {
			pos = pos.add(dir);
			map.set(pos, true);
		}
		return map.size();
	}

	public static function countHousesWithPresents2(input:String):Int {
		var santa = new Point(0, 0);
		var roboSanta = new Point(0, 0);
		var santasTurn = true;
		var map = new HashMap<Point, Bool>();
		map.set(santa, true);
		for (dir in parse(input)) {
			map.set(if (santasTurn) {
				santa = santa.add(dir);
			} else {
				roboSanta = roboSanta.add(dir);
			}, true);
			santasTurn = !santasTurn;
		}
		return map.size();
	}
}
