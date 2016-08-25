import "VObjectFactory.sol";
import "VEnv.sol";

contract Tester {
  address public result;
  VObjectFactory public factory;
  
  function Tester() {
    factory = new VObjectFactory();
  }

  function test(uint[] bytecode) {
    VEnv env = new VEnv(AbstractFactory(factory));

    result = 0; // Just for paranoia, clear the result.
    result = env.doMessage(bytecode);
  }
}
