package days;

class Day21 {
	public static function findWinner(player:Fighter, boss:Fighter):Winner {
		function attack(attacker:Fighter, defender:Fighter):Bool {
			defender.hitPoints -= Std.int(Math.max(1, attacker.damage - defender.armor));
			return defender.hitPoints <= 0;
		}
		while (true) {
			if (attack(player, boss)) {
				return Player;
			}
			if (attack(boss, player)) {
				return Boss;
			}
		}
	}

	static function parse(input:String):Shop {
		var sections = input.split("\n\n");
		function parseSection(i:Int, offset:Int):Array<Item> {
			return sections[i].split("\n").slice(1).map(function(line) {
				var parts = ~/\s+/g.split(line);
				return {
					name: parts[0],
					cost: Std.parseInt(parts[1 + offset]),
					damage: Std.parseInt(parts[2 + offset]),
					armor: Std.parseInt(parts[3 + offset]),
				}
			});
		}
		return {
			weapons: parseSection(0, 0),
			armor: parseSection(1, 0),
			rings: parseSection(2, 1)
		};
	}

	static function simulatePossibleFights(input:String, boss:Fighter):Array<{equipment:Item, winner:Winner}> {
		var shop = parse(input);
		function emptyItem():Item {
			return {
				name: "None",
				cost: 0,
				damage: 0,
				armor: 0
			}
		}
		shop.armor.push(emptyItem());
		shop.rings.push(emptyItem());
		shop.rings.push(emptyItem());
		function merge(items:Array<Item>):Item {
			return {
				name: "Combined",
				cost: items.map(i -> i.cost).sum(),
				damage: items.map(i -> i.damage).sum(),
				armor: items.map(i -> i.armor).sum(),
			};
		}

		var results = [];
		for (weapon in shop.weapons) {
			for (armor in shop.armor) {
				for (ring1 in shop.rings) {
					for (ring2 in shop.rings) {
						if (ring1 == ring2) {
							continue;
						}
						var equipment = merge([weapon, armor, ring1, ring2]);
						var player:Fighter = {
							hitPoints: 100,
							damage: equipment.damage,
							armor: equipment.armor
						};
						results.push({
							equipment: equipment,
							winner: findWinner(player, Reflect.copy(boss))
						});
					}
				}
			}
		}
		return results;
	}

	public static function findMinimumGoldToWin(input:String, boss:Fighter):Int {
		return simulatePossibleFights(input, boss).filter(fight -> fight.winner == Player).min(fight -> fight.equipment.cost).value;
	}

	public static function findMaximumGoldToLose(input:String, boss:Fighter) {
		return simulatePossibleFights(input, boss).filter(fight -> fight.winner == Boss).max(fight -> fight.equipment.cost).value;
	}
}

private typedef Shop = {
	final weapons:Array<Item>;
	final armor:Array<Item>;
	final rings:Array<Item>;
}

private typedef Item = {
	final name:String;
	final cost:Int;
	final damage:Int;
	final armor:Int;
}

typedef Fighter = {
	var hitPoints:Int;
	final damage:Int;
	final armor:Int;
}

enum Winner {
	Player;
	Boss;
}
