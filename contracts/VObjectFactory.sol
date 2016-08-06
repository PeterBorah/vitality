import "VObject.sol";

contract VObjectFactory {
  function create(VObject proto) returns(VObject) {
    return new VObject(proto);
  }
}
