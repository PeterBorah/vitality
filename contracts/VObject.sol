import "CallObject.sol";
import "AbstractFactory.sol";

contract VObject {
  mapping (uint => address) slots;
  AbstractFactory factory;
  VObject proto;

  function VObject(VObject _proto) {
    factory = AbstractFactory(msg.sender);
    proto = _proto;

    // Temporary for testing.
    slots[0x616e4f626a656374] = this; // anObject
  }
  
  function setSlot(uint name, address target) {
    slots[name] = target;
  }

  function doMessage(uint[] bytecode) returns(address) {
    VObject target = this;
    uint nextIndex;
    uint argSize;
    uint message;
    uint argNum;
    uint length;
    uint[] memory arg;
    uint j;

    while (nextIndex < bytecode.length) {
      message = bytecode[nextIndex];
      argNum = bytecode[nextIndex + 1];
      argSize = 0;
      length = 0;
      j = 0;

      CallObject callObj = new CallObject();

      for(uint i = 0; i < argNum; i++) {
        length = bytecode[nextIndex + 2 + i];
        arg = new uint[](length);
        callObj.setArgNum(argNum);
        
        for (j = 0; j < length; j++) {
          callObj.addToArg(i, bytecode[nextIndex + 2 + argNum + argSize + j]);
        }
        argSize += length;
      }

      target = VObject(target.processMessage(message, callObj));
      nextIndex += 2 + argNum + argSize;
    }
    
    return target;
  }

  function invoke(CallObject callObj) returns(address) {
  }

  function processMessage(uint message, CallObject callObj) returns(address) {
    // setSlot
    if (message == 0x736574536c6f74) {
      return _setSlot(callObj);
    }

    // clone
    if (message == 0x636c6f6e65) {
      return _vclone(callObj);
    }

    // if not here, check prototype
    if (proto != address(0) && slots[message] == 0) {
      return proto.processMessage(message, callObj);
    }

    // normal case
    if (callObj.argNum() == 0) {
      return slots[message];
    } else {
      return VObject(slots[message]).invoke(callObj);
    }
  }

  function _setSlot(CallObject callObj) private returns(address) {
    slots[callObj.args(0,0)] = address(callObj.evalArgAt(1));
    return this;
  }

  function _mul(CallObject callObj) private returns(address) {
    return address(callObj.args(0,0) * callObj.args(1,0));
  }

  function _vclone(CallObject callObj) private returns(address) {
    return VObject(factory.create(this));
  }
}
