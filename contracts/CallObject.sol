contract CallObject {
  uint[][] public args;

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
}
