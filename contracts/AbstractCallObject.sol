contract AbstractCallObject {
  function args(uint, uint) returns(uint);
  function sender() returns(address);
  function target() returns(address);
  function initialize(address, address);
  function argNum() returns(uint);
  function argLength(uint) returns(uint);
  function setArgNum(uint);
  function addToArg(uint, uint);
  function evalArgAt(uint) returns(address);
}
