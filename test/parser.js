var parser = require("../javascript/parser.js");

contract('Parser', function(accounts) {
  it("Can split a code string into tokens", function() {
    code = "setSlot('double', method(x, x +(x))); double(3); 1;";
    expected = ["setSlot(", "'double'", ",", "method(", "x", ",", "x", "+(", "x", ")", ")", ")", ";", "double(", "3", ")", ";", "1", ";"];
    assert.deepEqual(parser.tokenize(code), expected);
  });

  xit("Can get a list of identifiers", function() {
    code = "setSlot('doublePlusOne', method(x, 1 +(x, x)))";
    intermediate = parser.getIntermediate(parser.tokenize(code));
    console.log(intermediate);
  });

  xit("Can turn it into bytecode", function() {
    code = "setSlot('doublePlusOne', method(x, 1 +(x, x)))";
    intermediate = parser.getIntermediate(parser.tokenize(code));
    console.log(parser.getBytecode(intermediate));
  });

  xit("Can do the whole thing", function() {
    code = "setSlot('doublePlusOne', method(x, 1 +(x, x)))";
    console.log(parser.parse(code));
  });
});
