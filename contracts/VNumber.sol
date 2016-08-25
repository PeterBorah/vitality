import "VObject.sol";

contract VNumber is VObject {
  function VNumber(AbstractFactory _factory) VObject(VObject(0), _factory) {
  }

  function processMessage(uint message, CallObject callObj) returns(address) {
    // new
    if (message == 0x6e6577) {
      return _new(callObj);
    }

    // normal case
    return super.processMessage(message, callObj);
  }

  function _new(CallObject callObj) returns(address) {
    VObject newObj = VObject(factory.create(this));
    newObj.setSlot(0x72617756616c7565, address(callObj.args(0,0)));
    return newObj;
  }
}
