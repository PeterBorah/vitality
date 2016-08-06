import "VObject.sol";
import "VObjectFactory.sol";

contract Tester {
  address public result;
  VObjectFactory public factory;
  
  function Tester() {
    factory = new VObjectFactory();
  }

  function test(uint[] bytecode) {
    VObject obj = factory.create();

    result = 0; // Just for paranoia, clear the result.
    result = obj.exec(bytecode);
  }
}
