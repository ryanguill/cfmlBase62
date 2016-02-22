component extends="testbox.system.BaseSpec" {

	function run () {
		describe("basic suite", function() {

			var base62 = new lib.base62();

			it("serializes & deserializes", function() {
				var input = 123;
				var x = base62.fromBase10(input);
				expect(x).notToBe(123);
				expect(x).toBe("b9");
				var y = base62.toBase10(x);
				expect(y).toBe(input);
			});
		});

	}


}