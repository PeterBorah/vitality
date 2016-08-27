contract AbstractVObject {
  function setSlot(uint, address);
  function doMessage(uint[]) returns(address);
  function initialize(address, address);
}
