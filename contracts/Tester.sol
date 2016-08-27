import "VObjectFactory.sol";
import "VEnv.sol";

contract Tester {
  address public result;
  VObjectFactory public factory;
  VEnv public env;
  
  function Tester() {
    factory = new VObjectFactory();
  }

  function prepare() {
    result = 0; // Just for paranoia, clear the result.
    env = new VEnv(AbstractFactory(factory));
  }
    

  function test(uint[] bytecode) {
    result = env.doMessage(bytecode);
  }
}
