import "CallObject.sol";
import "AbstractFactory.sol";

contract VObject {
  mapping (uint => address) slots;
  AbstractFactory factory;

  function VObject() {
    factory = AbstractFactory(msg.sender);

    // Temporary for testing.
    slots[0x746865416e73776572] = 42; // theAnswer
    slots[0x616e4f626a656374] = this; // anObject
  }
  
  function setSlot(uint name, address target) {
    slots[name] = target;
  }

  function exec(uint[] bytecode) returns(address) {
    VObject target = this;
    uint nextIndex = 0;

    while (nextIndex < bytecode.length) {
      uint message = bytecode[nextIndex];
      uint argNum = bytecode[nextIndex + 1];
      uint argSize;
      uint length;
      uint[] memory arg;
      uint j;

      CallObject callObj = new CallObject();

      for(uint i; i < argNum; i++) {
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

    // mul
    if (message == 0x6d756c) {
      return _mul(callObj);
    }

    // clone
    if (message == 0x636c6f6e65) {
      return _clone(callObj);
    }

    if (callObj.argNum() == 0) {
      return slots[message];
    } else {
      return VObject(slots[message]).invoke(callObj);
    }
  }

  function _setSlot(CallObject callObj) private returns(address) {
    slots[callObj.args(0,0)] = address(callObj.args(1,0));
    return this;
  }

  function _mul(CallObject callObj) private returns(address) {
    return address(callObj.args(0,0) * callObj.args(1,0));
  }

  function _clone(CallObject callObj) private returns(address) {
    return VObject(factory.create());
  }
}
