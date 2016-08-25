import "VObjectFactory.sol";
import "VEnv.sol";

contract Tester {
  address public result;
  VObjectFactory public factory;
  VEnv public env;
  
  function Tester() {
    factory = new VObjectFactory();
    env = new VEnv();
  }

  function test(uint[] bytecode) {
    VObject obj = factory.create(env);

    result = 0; // Just for paranoia, clear the result.
    result = obj.doMessage(bytecode);
  }
}
