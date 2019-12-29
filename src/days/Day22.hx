package days;

import AStar.Move;

class Day22 {
	public static function simulateTurn(state:State, spell:Spell, bossDamage:Int):Null<Move<State>> {
		var playerHP = state.playerHP;
		var playerMana = state.playerMana;
		var bossHP = state.bossHP;

		var shieldLeft = state.shieldLeft;
		var poisonLeft = state.poisonLeft;
		var rechargeLeft = state.rechargeLeft;
		function applyEffects() {
			if (shieldLeft > 0) {
				shieldLeft--;
			}
			if (poisonLeft > 0) {
				bossHP -= 3;
				poisonLeft--;
			}
			if (rechargeLeft > 0) {
				playerMana += 101;
				rechargeLeft--;
			}
		}

		// player turn
		applyEffects();

		var cost = 0;
		switch spell {
			case MagicMissile:
				cost = 53;
				bossHP -= 4;

			case Drain:
				cost = 73;
				bossHP -= 2;
				playerHP += 2;

			case Shield if (shieldLeft == 0):
				cost = 113;
				shieldLeft = 6;

			case Poison if (poisonLeft == 0):
				cost = 173;
				poisonLeft = 6;

			case Recharge if (rechargeLeft == 0):
				cost = 229;
				rechargeLeft = 5;

			case _:
				return null;
		}
		playerMana -= cost;
		if (playerMana < 0) {
			return null;
		}

		// boss turn
		applyEffects();
		if (bossHP > 0) {
			playerHP -= Std.int(Math.max(1, bossDamage - if (shieldLeft > 0) 7 else 0));
		}

		if (playerHP > 0 || bossHP < 0) {
			return {
				state: new State(state.spells.concat([spell]), shieldLeft, poisonLeft, rechargeLeft, playerHP, playerMana, bossHP),
				cost: cost
			};
		}
		return null;
	}

	public static function simulateBattle(playerHP:Int, playerMana:Int, bossHP:Int, bossDamage:Int, spells:Array<Spell>) {
		var state = new State([], 0, 0, 0, playerHP, playerMana, bossHP);
		while (spells.length > 0) {
			var move = simulateTurn(state, spells.shift(), bossDamage);
			Sys.println(move);
			if (move == null) {
				return state;
			}
			state = move.state;
		}
		return state;
	}

	public static function findMinimumManaToWin(playerHP:Int, playerMana:Int, bossHP:Int, bossDamage:Int):Int {
		return AStar.search([new State([], 0, 0, 0, playerHP, playerMana, bossHP)], s -> s.bossHP <= 0, s -> s.bossHP * 50, function(state) {
			var moves = [];
			for (spell in Type.allEnums(Spell)) {
				var move = simulateTurn(state, spell, bossDamage);
				if (move != null) {
					moves.push(move);
				}
			}
			return moves;
		}).score;
	}
}

class State {
	public final spells:Array<Spell>;
	public final shieldLeft:Int;
	public final poisonLeft:Int;
	public final rechargeLeft:Int;
	public final playerHP:Int;
	public final playerMana:Int;
	public final bossHP:Int;

	public function new(spells, shieldLeft, poisonLeft, rechargeLeft, playerHP, playerMana, bossHP) {
		this.spells = spells;
		this.shieldLeft = shieldLeft;
		this.poisonLeft = poisonLeft;
		this.rechargeLeft = rechargeLeft;
		this.playerHP = playerHP;
		this.playerMana = playerMana;
		this.bossHP = bossHP;
	}

	public function hashCode():String {
		return Std.string(spells);
	}
}

enum Spell {
	MagicMissile;
	Drain;
	Shield;
	Poison;
	Recharge;
}
