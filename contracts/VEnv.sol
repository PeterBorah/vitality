import "VObject.sol";

contract VEnv is VObject {
  function VEnv() VObject(VObject(0)) {
    // temporary for testing
    slots[0x746865416e73776572] = 42; // theAnswer
  }

  function processMessage(uint message, CallObject callObj) returns(address) {
    // mul
    if (message == 0x6d756c) {
      return _mul(callObj);
    }

    // normal case
    return super.processMessage(message, callObj);
  }

  function _mul(CallObject callObj) private returns(address) {
    return address(callObj.args(0,0) * callObj.args(1,0));
  }

}
