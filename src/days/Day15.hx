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

	public static function generateSolver(input:String):String {
		var ingredients = parse(input);
		var lines = ["from gekko import GEKKO", "m = GEKKO()", "m.options.SOLVER=1"];
		function addEquation(equation:String) {
			lines.push('m.Equation($equation)');
		}
		function makeTerm(index:Int):String {
			return ingredients.filter(i -> i.properties[index] != 0).map(i -> "(" + i.properties[index] + " * " + i.name + ")").join(" + ");
		}
		lines = lines.concat(ingredients.map(i -> '${i.name} = m.Var(integer=True)'));
		addEquation(ingredients.map(i -> i.name).join(" + ") + " == 100");
		addEquation(makeTerm(4) + " == 500");
		var terms = [];
		for (j in 0...4) {
			var term = makeTerm(j);
			terms.push(term);
			addEquation(term += " >= 1");
		}
		var objective = terms.map(t -> '($t)').join(" * ");
		lines.push('m.Maximize($objective)');
		lines.push("m.options.IMODE = 2");
		lines.push("m.solve()");
		lines = lines.concat(ingredients.map(i -> 'print("${i.name} =" + str(${i.name}.value))'));
		lines.push('print(str(${~/([A-Za-z]+)/g.map(objective, e -> e.matched(1) + ".value[0]")}))');
		return lines.join("\n");
	}
}

private typedef Ingredient = {
	final name:String;
	final properties:Properties;
}

private typedef Properties = Array<Int>;
