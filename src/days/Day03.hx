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
		map[pos] = true;
		for (dir in parse(input)) {
			pos += dir;
			map[pos] = true;
		}
		return map.size();
	}

	public static function countHousesWithPresents2(input:String):Int {
		var santa = new Point(0, 0);
		var roboSanta = new Point(0, 0);
		var santasTurn = true;
		var map = new HashMap<Point, Bool>();
		map[santa] = true;
		for (dir in parse(input)) {
			map[
				if (santasTurn) {
					santa += dir;
				} else {
					roboSanta += dir;
				}
			] = true;
			santasTurn = !santasTurn;
		}
		return map.size();
	}
}
