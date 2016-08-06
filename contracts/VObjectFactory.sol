import "VObject.sol";

contract VObjectFactory {
  function create() returns(VObject) {
    return new VObject();
  }
}
