var parser = require("../javascript/parser.js");

contract('Parser', function(accounts) {
  it("Can split a code string into tokens", function() {
    code = "setSlot('double', method(x, x +(x))); double(3); 1;";
    expected = ["setSlot(", "'double'", ",", "method(", "x", ",", "x", "+(", "x", ")", ")", ")", ";", "double(", "3", ")", ";", "1", ";"];
    assert.deepEqual(parser.tokenize(code), expected);
  });

  it("Can get an intermediate representation", function() {
    code = "setSlot('doublePlusOne', method(x, 1 +(x, x)))";
    expected = [{type: "identifier", value: "setSlot"}, {type: "argNumber", value: 2}, {type: "argSize", value: 1}, {type: "argSize", value: 12},
      {type: "string", value: "doublePlusOne"}, {type: "identifier", value: "method"}, {type: "argNumber", value: 2}, {type: "argSize", value: 1},
      {type: "argSize", value: 7}, {type: "identifier", value: "x"}, {type: "number", value: 1}, {type: "identifier", value: "+"},
      {type: "argNumber", value: 2}, {type: "argSize", value: 1}, {type: "argSize", value: 1}, {type: "identifier", value: "x"}, {type: "identifier", value: "x"}]
    assert.deepEqual(parser.getIntermediate(parser.tokenize(code)), expected);
  });
});
