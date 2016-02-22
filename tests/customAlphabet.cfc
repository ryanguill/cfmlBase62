component extends="testbox.system.BaseSpec" {

	function run () {
		describe("custom alphabet suite", function() {

			var base62 = new lib.base62();
			//here is where things differ
			base62.setAlphabet(base62.getShuffledAlphabet());
			var threadLocalRandom = createObject("java", "java.util.concurrent.ThreadLocalRandom");

			function serializeDeserializeTest(input, expectedSerializedValue) {
				var serialized = base62.fromBase10(input);
				expect(serialized).notToBe(input);

				if (!isNull(expectedSerializedValue)) {
					expect(serialized).toBe(expectedSerializedValue);
				}

				var deserialized = base62.toBase10(serialized);
				expect(deserialized).toBe(input);

				writedump(var=input & " | " & serialized, output="console");
			}

			it("serializes & deserializes", function() {
				serializeDeserializeTest(123);
			});

			it("works with max integer", function() {
				serializeDeserializeTest(2147483647);
			});

			it("works with bigints", function() {
				serializeDeserializeTest(9223372036854775807);
			});

			it("doesnt work with one more than the higest bigint", function() {
				expect(function() {
					serializeDeserializeTest(9223372036854775808);
				}).toThrow();
			});

			it("works with zero", function() {
				serializeDeserializeTest(0);
			});

			it("doesnt work with negative numbers", function() {
				expect(function() {
					serializeDeserializeTest(-1);
				}).toThrow();
			});

			it("works with random integers", function() {
				for (var i = 0; i < 1000; i++) {
					serializeDeserializeTest(threadLocalRandom.current().nextInt(0, 2147483647));
				}
			});

			it("works with random bigintegers", function() {
				for (var i = 0; i < 1000; i++) {
					serializeDeserializeTest(threadLocalRandom.current().nextLong(0, 9223372036854775808));
				}
			});

			it("generates a different shuffled alphabet each time", function() {
				var one = base62.getShuffledAlphabet();
				var two = base62.getShuffledAlphabet();
				var three = base62.getShuffledAlphabet();
				var four = base62.getShuffledAlphabet();
				var five = base62.getShuffledAlphabet();

				expect(one).notToBe(two);
				expect(one).notToBe(three);
				expect(one).notToBe(four);
				expect(one).notToBe(five);

				expect(two).notToBe(three);
				expect(two).notToBe(four);
				expect(two).notToBe(five);

				expect(three).notToBe(four);
				expect(three).notToBe(five);

				expect(four).notToBe(five);

				expect(len(one)).toBe(62);
				expect(len(two)).toBe(62);
				expect(len(three)).toBe(62);
				expect(len(four)).toBe(62);
				expect(len(five)).toBe(62);
			});

			it("should throw an error if you try to set a bogus alphabet", function(){
				expect(function(){
					base62.setAlphabet("");
				}).toThrow();

				expect(function(){
					base62.setAlphabet("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!");
				}).toThrow();

				expect(function(){
					base62.setAlphabet("aacdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789");
				}).toThrow();

				expect(function(){
					base62.setAlphabet("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ012345678");
				}).toThrow();
			});

		});

	}


}