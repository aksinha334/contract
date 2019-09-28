const Document = artifacts.require("Document.sol");

module.exports = function(deployer) {
  deployer.deploy(Document);
};
