component extends="testbox.system.BaseSpec" {

	function run () {
		describe("basic suite", function() {

			var base62 = new lib.base62();
			var threadLocalRandom = createObject("java", "java.util.concurrent.ThreadLocalRandom");

			var serializeDeserializeTest = function (input, expectedSerializedValue) {
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
				serializeDeserializeTest(123, "b9");
			});

			it("works with max integer", function() {
				serializeDeserializeTest(2147483647, "cvuMLb");
			});

			it("works with bigints", function() {
				serializeDeserializeTest("9223372036854775807", "k9viXaIfiWh");
			});

			it("doesnt work with one more than the higest bigint", function() {
				expect(function() {
					serializeDeserializeTest("9223372036854775808");
				}).toThrow();
			});

			it("works with zero", function() {
				serializeDeserializeTest(0, "a");
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

		});

	}


}
