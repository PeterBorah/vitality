import "VObject.sol";
import "VEnv.sol";
import "AbstractFactory.sol";
import "AbstractVObject.sol";
import "TinyRouter.sol";
import "CallObject.sol";
import "AbstractCallObject.sol";

contract VObjectFactory {
  VObject template;
  CallObject callObjTemplate;

  function VObjectFactory() {
    template = new VObject();
    callObjTemplate = new CallObject();
  }

  function create(VObject proto) returns(AbstractVObject) {
    AbstractVObject result = AbstractVObject(new TinyRouter(template));
    result.initialize(proto, this);
    return result;
  }

  function createCallObject(AbstractVObject target) returns(AbstractCallObject) {
    AbstractCallObject result = AbstractCallObject(new TinyRouter(callObjTemplate));
    result.initialize(target, AbstractVObject(msg.sender));
    return result;
  }
}
