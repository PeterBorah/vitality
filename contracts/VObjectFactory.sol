import "VObject.sol";
import "VEnv.sol";
import "AbstractFactory.sol";

contract VObjectFactory {
  function create(VObject proto) returns(VObject) {
    return new VObject(proto, AbstractFactory(this));
  }
}
