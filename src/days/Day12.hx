package days;

import haxe.DynamicAccess;
import haxe.Json;

class Day12 {
	public static function sumNumbers(input:String):Int {
		var numbers = [];
		~/-?\d+/g.map(input, function(e) {
			numbers.push(e.int(0));
			return "";
		});
		return numbers.sum();
	}

	public static function sumNonRedNumbers(input:String):Int {
		function sum(object:Any):Int {
			if (Std.is(object, Int)) {
				return cast object;
			} else if (Std.is(object, String)) {
				return 0;
			} else if (Std.is(object, Array)) {
				var array:Array<Dynamic> = object;
				return array.map(item -> sum(item)).sum();
			} else {
				var access:DynamicAccess<Dynamic> = object;
				var result = 0;
				for (value in access) {
					if (value == "red") {
						return 0;
					} else {
						result += sum(value);
					}
				}
				return result;
			}
		}
		return sum(Json.parse(input));
	}
}
