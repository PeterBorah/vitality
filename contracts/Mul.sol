import "CallObject.sol";

contract Mul {
  function invoke(CallObject callObj) returns(address) {
    return address(callObj.args(0,0) * callObj.args(1,0));
  }
}
