import "AbstractVObject.sol";

contract CallObject {
  address destination;
  uint[][] public args;
  AbstractVObject public sender;
  AbstractVObject public target;

  function initialize(AbstractVObject _target, AbstractVObject _sender) {
    target = _target;
    sender = _sender;
  }

  function argNum() returns(uint) {
    return args.length;
  }

  function argLength(uint index) returns(uint) {
    return args[index].length;
  }

  function setArgNum(uint num) {
    args.length = num;
  }

  function addToArg(uint index, uint element) {
    args[index].push(element);
  }

  function evalArgAt(uint index) returns(address) {
    return sender.doMessage(args[index]);
  }
}
