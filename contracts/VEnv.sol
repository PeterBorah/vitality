import "VObject.sol";
import "VNumber.sol";

contract VEnv is VObject {
  function VEnv(AbstractFactory _factory) VObject(VObject(0), _factory) {
    // temporary for testing
    slots[0x616e4f626a656374] = this; // anObject
    slots[0x746865416e73776572] = 42; // theAnswer
    slots[0x4e756d626572] = new VNumber(factory); // Number
  }

  function processMessage(uint message, CallObject callObj) returns(address) {
    // mul
    if (message == 0x6d756c) {
      return _mul(callObj);
    }

    // normal case
    return super.processMessage(message, callObj);
  }

  function _mul(CallObject callObj) returns(address) {
    return address(callObj.args(0,0) * callObj.args(1,0));
  }
}
