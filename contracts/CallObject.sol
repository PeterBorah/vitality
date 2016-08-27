import "AbstractVObject.sol";

contract CallObject {
  uint[][] public args;
  AbstractVObject public sender;
  AbstractVObject public target;

  function CallObject(AbstractVObject _target) {
    target = _target;
    sender = AbstractVObject(msg.sender);
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
