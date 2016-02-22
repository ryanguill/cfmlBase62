component {

	variables.DEFAULT_ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	variables.ALPHABET = variables.DEFAULT_ALPHABET;
	variables.BASE = bigInt(len(ALPHABET).longValue().toString());

	public any function init () {
		return this;
	}

	public void function setAlphabet (string alphabet) {
		if (len(alphabet) == len(variables.DEFAULT_ALPHABET) && !arrayHasDuplicates(alphabet.toCharArray())) {
			variables.ALPHABET = alphabet;
		} else {
			throw(message="Invalid Alphabet - the string must consist of all letters from a to z, both lower and upper case, and the digits 0 through 9");
		}
	}

	private boolean function arrayHasDuplicates (required array input) {
		var hs = createObject("java", "java.util.HashSet").init(arrayLen(input));
		for (var item in input) {
			if (hs.contains(item)) {
				return true;
			}
			hs.add(item);
		}

		return false;
	}

	public string function getShuffledAlphabet () {
		var alphabet = listToArray(variables.DEFAULT_ALPHABET, "");

		for (var i = arrayLen(alphabet); i > 1; i--) {
			var index = randRange(1, i);
			var tmp = alphabet[index];
			alphabet[index] = alphabet[i];
			alphabet[i] = tmp;
		}

		return arrayToList(alphabet, "");
	}

	private any function bigInt (required string input ){
		return createObject("java", "java.math.BigInteger").init(input);
	}

	private any function stringBuilder (string input = "") {
		return createObject("java", "java.lang.StringBuilder").init(input);
	}

	public string function fromBase10(required numeric i) {
		i = createObject("java", "java.lang.Long").valueOf(i);

		var sb = stringBuilder();
		if (i == 0) {
			fromBase10Builder(i, sb);
		} else {
			while (i > 0) {
				i = fromBase10Builder(i, sb);
			}
		}
		return sb.reverse().toString();
	}

	private numeric function fromBase10Builder (required numeric i, required any sb) {
		var bi = bigInt(i.longValue().toString());
		var rem = bi.mod(BASE).intValue();
		sb.append(ALPHABET.charAt(rem));
		return bi.divide(BASE);
	}

	public numeric function toBase10 (required string str) {
		str = str.replaceAll("[^a-zA-Z0-9]", "");
		return toBase10Helper(stringBuilder(str).reverse().toString().toCharArray()).longValue();
	}

	private numeric function toBase10Helper (required array chars) {
		var n = bigInt("0");
		for (var i = arrayLen(chars)-1; i >= 0; i--) {
			n = n.add(toBase10Power(ALPHABET.indexOf(chars[i+1]), i));
		}
		return n;
	}

	private numeric function toBase10Power (required numeric n, required numeric pow) {
		var bi = bigInt(n.longValue().toString());
		return bi.multiply(BASE.pow(pow.intValue()));
	}

}