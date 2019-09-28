pragma solidity ^0.5.11;
contract Document {
  address payable owner;
  uint minWei;
  // Struct having blueprint how to save data in network
  struct Data {
    string author;
    uint mineTime;
    uint blockNumber;
    uint docHash;
  }

  //Mapping the document hashValue with struct Data
  mapping (uint => Data) private docHashs;
  // Mapping the existence of document hash with boolean
  mapping (uint => bool) private exists;
  constructor() public  {
    owner = msg.sender;
  }

  // Only Owner
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
  // Accept minimum wei
  modifier acceptMinWei() {
    require(msg.value >= minWei);
    _;

  }
  // View the contract balance
  function getContractBalance() public view onlyOwner returns (uint) {
    return address(this).balance;
  }

  // Setting the minimum wei
  function setPayablewei(uint setWei) public onlyOwner{
    minWei = setWei;
  }

  // Kill Contract
  function killContract() public onlyOwner {
    selfdestruct(owner);
  }

  // Get Balance
  function getBalance() public view returns (uint) {
    return msg.sender.balance;
  }

  // Checking Document HashValue is register in network or not
  function isDocHashRegister (uint hashValue) internal view returns (bool) {
    if (!exists[hashValue]){
      return false;
    }
    return true;
  }

  // transferring balance from contract
  function transferBalanceFromContract(uint value) public onlyOwner returns(bool success ) {
    
  }

  // Registering the document With name of Author and HashValue
  function registerDocument(string memory author, uint hashValue) public payable acceptMinWei{
    require(isDocHashRegister(hashValue) == false, 'Dochash already present in blockchain');
    Data memory dataTmp = Data(author, now, block.number, hashValue);
    docHashs[hashValue] = dataTmp;
    exists[hashValue] = true;
  }

  // Fetching the Document registration detail using hashValue
  function getDocByHashValue(uint hashValue) public view returns(string memory, uint, uint, uint) {
    require(isDocHashRegister(hashValue) == true, 'HashValue is not assigned in blockchain');
    return (docHashs[hashValue].author, docHashs[hashValue].mineTime, docHashs[hashValue].blockNumber, docHashs[hashValue].docHash);
  }



}
