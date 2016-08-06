import "AbstractVObject.sol";
import "CallObject.sol";

contract SlotSetter {
  AbstractVObject parent;

  function SlotSetter() {
    parent = AbstractVObject(msg.sender);
  }

  function invoke(CallObject callObj) returns(address) {
    parent.setSlot(callObj.args(0,0), address(callObj.args(1,0)));
    return parent;
  }
}
