var MyMileage = artifacts.require("MyMileage");
module.exports = function (_deployer) {
  _deployer.deploy(MyMileage);
};
