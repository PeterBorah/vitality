import "VObject.sol";

contract VNumber is VObject {
  function VNumber(VObject _proto, AbstractFactory _factory) {
    proto = _proto;
    factory = _factory;
  }

  function processMessage(uint message, AbstractCallObject callObj) returns(address) {
    // new
    if (message == 0x6e6577) {
      return _new(callObj);
    }

    // +
    if (message == 0x2b) {
      return _plus(callObj);
    }

    // normal case
    return super.processMessage(message, callObj);
  }

  function _new(AbstractCallObject callObj) returns(address) {
    return _createNewNumber(callObj.args(0,0));
  }

  function _plus(AbstractCallObject callObj) returns(address) {
    VObject first = VObject(callObj.target());
    VObject second = VObject(callObj.evalArgAt(0));

    uint resultVal = uint(first.rawValue()) + uint(second.rawValue());
    return _createNewNumber(resultVal);
  }

  function _createNewNumber(uint value) returns(address) {
    VObject result = VObject(factory.create(this));
    result.setSlot(0x72617756616c7565, address(value));
    return address(result);
  }
}
