// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DevairToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("DevToken", "DVT") {
        _mint(msg.sender, initialSupply);
    }

}

contract ProMang {

    // What does each property have. 
    // Name of the property, 
    // Type of the propery (houses, cars)
    // Id of the property, to help to know wich property was added first.
    error NOT_THE_OWNER();

    address public owner;

    address public buyer;

    struct Property{
        string name;
        string proType;
        string prices;
        uint8 Id;
        bool forSale;

    }

    uint8 pro_Id = 1;

    Property[] public properties;

    modifier onlyOwner() {
        if (owner != msg.sender) {
            revert NOT_THE_OWNER();
        }
        _;
    }


    mapping(address => Property) payment;

    constructor() {
        owner = msg.sender;
    }

    function createProperty(string memory _name, string memory _proType,string memory _prices) external {

        Property memory newProperty = Property({name: _name , proType: _proType, prices: _prices, Id:pro_Id , forSale: false});
        // payment[msg.sender] = Property({name: _name , proType: _proType, Id:pro_Id });

        properties.push(newProperty);
        pro_Id ++;
        
    }

    function rmvProperty(uint8 _index)external onlyOwner {
        require(_index < properties.length, "Index out of bonds");

        for (uint256 i = _index; i < properties.length - 1; i++) {
            properties[i] = properties[i + 1];
        }

        properties.pop();   //to learn more on arrays, and remove, arrays, invest in them.
        // Property memory removeProperty = Property({name: _name , proType: _proType, Id:pro_Id })

    }

    function getAllProperties() external view returns(Property[] memory){
        return properties;

    }

    function setPropertyForSale() external {
    


    }

    function payForProperty(address) external payable {


    }

    function buyProperty(address) external payable {

    }



}