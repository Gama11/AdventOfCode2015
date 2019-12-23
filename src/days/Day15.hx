package days;

class Day15 {
	static function parse(input:String):Array<Ingredient> {
		return input.split("\n").map(function(line) {
			var parts = line.split(" ");
			return {
				name: parts[0].replace(":", ""),
				properties: parts.map(Std.parseInt).filter(i -> i != null)
			};
		});
	}

	static function sum(a:Properties, b:Properties):Properties {
		return [for (i in 0...4) a[i] + b[i]];
	}

	static function score(p:Properties):Int {
		return p.slice(0, 4).map(total -> if (total < 0) 0 else total).fold((a, b) -> a * b, 1);
	}

	public static function findHighestScoringCookie(input:String):Int {
		var ingredients = parse(input);
		var cookie = [for (_ in 0...5) 0];
		for (ingredient in ingredients) {
			cookie = sum(ingredient.properties, cookie);
		}
		for (_ in 0...100 - ingredients.length) {
			cookie = ingredients.map(ingredient -> sum(ingredient.properties, cookie)).max(cookie -> score(cookie)).list[0];
		}
		return score(cookie);
	}
}

private typedef Ingredient = {
	final name:String;
	final properties:Properties;
}

private typedef Properties = Array<Int>;
