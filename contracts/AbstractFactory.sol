contract AbstractFactory {
  function create(address) returns(address);
  function createCallObject(address) returns(address);
}
