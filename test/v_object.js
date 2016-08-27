var parser = require("../javascript/parser.js");

// Use testrpc's -l flag to set a high enough gas limit.
contract('VObject', function(accounts) {
  it("can process a single message", function(done) {
    code = "theAnswer";
    bytecode = parser.parse(code);
    tester = Tester.deployed();

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
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

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
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

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
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

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
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

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
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

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
      then(function() { return tester.result() }).
      then(function(result) {
        assert.equal(result, 42);
        done();
      }).catch(done);
  });

  it("can handle numbers", function(done) {
    code = "4";
    bytecode = parser.parse(code);
    tester = Tester.deployed();
    var num;

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
      then(function() { return tester.result() }).
      then(function(result) { num = VObject.at(result); }).
      then(function() { return num.rawValue(); }).
      then(function(result) {
        assert.equal(result, 4);
        done();
      }).catch(done);
  });

  it("can set slots to numbers", function(done) {
    code = "setSlot(result, 4) result";
    bytecode = parser.parse(code);
    tester = Tester.deployed();
    var num;

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
      then(function() { return tester.result() }).
      then(function(result) { num = VObject.at(result); }).
      then(function() { return num.rawValue(); }).
      then(function(result) {
        assert.equal(result, 4);
        done();
      }).catch(done);
  });

  it("can add numbers", function(done) {
    code = "4 +(7)";
    bytecode = parser.parse(code);
    tester = Tester.deployed();
    var num;

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
      then(function() { return tester.result() }).
      then(function(result) { num = VObject.at(result); }).
      then(function() { return num.rawValue(); }).
      then(function(result) {
        assert.equal(result, 11);
        done();
      }).catch(done);
  });

  it("can add things that aren't just literals", function(done) {
    code = "4 +(anObject 5)";
    bytecode = parser.parse(code);
    tester = Tester.deployed();
    var num;

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
      then(function() { return tester.result() }).
      then(function(result) { num = VObject.at(result); }).
      then(function() { return num.rawValue(); }).
      then(function(result) {
        assert.equal(result, 9);
        done();
      }).catch(done);
  });

  it("can set slots to addition", function(done) {
    code = "setSlot(result, 4 +(3)) result";
    bytecode = parser.parse(code);
    tester = Tester.deployed();
    var num;

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
      then(function() { return tester.result() }).
      then(function(result) { num = VObject.at(result); }).
      then(function() { return num.rawValue(); }).
      then(function(result) {
        assert.equal(result, 7);
        done();
      }).catch(done);
  });

  it("can add nested numbers", function(done) {
    code = "5 +(4 +(3 +(2 +(1))))";
    bytecode = parser.parse(code);
    tester = Tester.deployed();
    var num;

    tester.prepare().
      then(function() { return tester.test(bytecode, {gas: 99999999}) }).
      then(function() { return tester.result() }).
      then(function(result) { num = VObject.at(result); }).
      then(function() { return num.rawValue(); }).
      then(function(result) {
        assert.equal(result, 15);
        done();
      }).catch(done);
  });
});
