var parser = require("../javascript/parser.js");

contract('VObject', function(accounts) {
  it("can process a single message", function(done) {
    code = "theAnswer";
    bytecode = parser.parse(code);
    tester = Tester.deployed();

    tester.test(bytecode).
      then(function() { return tester.result() }).
      then(function(result) {
        assert.equal(result, 42);
        done();
      }).catch(done);
  });

  it("can process a message chain", function(done) {
    code = "anObject theAnswer";
    bytecode = parser.parse(code);
    tester = Tester.deployed();

    tester.test(bytecode).
      then(function() { return tester.result() }).
      then(function(result) {
        assert.equal(result, 42);
        done();
      }).catch(done);
  });

  it("can clone an object", function(done) {
    code = "anObject clone theAnswer";
    bytecode = parser.parse(code);
    tester = Tester.deployed();

    tester.test(bytecode).
      then(function() { return tester.result() }).
      then(function(result) {
        assert.equal(result, 42);
        done();
      }).catch(done);
  })

  it("can handle passing arguments", function(done) {
    code = "mul(0x2, 0x3)";
    bytecode = parser.parse(code);
    tester = Tester.deployed();

    tester.test(bytecode).
      then(function() { return tester.result() }).
      then(function(result) {
        assert.equal(result, 6);
        done();
      }).catch(done);
  });

  it("can set slots", function(done) {
    code = "setSlot(bestNumber, theAnswer) bestNumber";
    bytecode = parser.parse(code);
    tester = Tester.deployed();

    tester.test(bytecode).
      then(function() { return tester.result() }).
      then(function(result) {
        assert.equal(result, 42);
        done();
      }).catch(done);
  });

  it("sets prototype of clone", function(done) {
    code = "setSlot(bestNumber, theAnswer) clone bestNumber";
    bytecode = parser.parse(code);
    tester = Tester.deployed();

    tester.test(bytecode).
      then(function() { return tester.result() }).
      then(function(result) {
        assert.equal(result, 42);
        done();
      }).catch(done);
  });
});
