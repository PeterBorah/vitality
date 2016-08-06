import "CallObject.sol";
import "AbstractFactory.sol";
import "Mul.sol";
import "SlotSetter.sol";

contract VObject {
  mapping (uint => address) slots;
  AbstractFactory factory;
  SlotSetter slotSetter;

  function VObject() {
    factory = AbstractFactory(msg.sender);
    slotSetter = new SlotSetter();

    // Temporary for testing.
    slots[0x746865416e73776572] = 42; // theAnswer
    slots[0x616e4f626a656374] = this; // anObject
    slots[0x6d756c] = new Mul(); // mul
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

  function getSlot(uint message) returns(address) {
    // Clone
    if (message == 0x636c6f6e65) {
      return VObject(factory.create());
    }

    if (message == 0x736574536c6f74) {
      return slotSetter;
    }

    // otherwise
    return slots[message];
  }

  function processMessage(uint message, CallObject callObj) returns(address) {
    if (callObj.argNum() == 0) {
      return getSlot(message);
    } else {
      return VObject(getSlot(message)).invoke(callObj);
    }
  }
}
