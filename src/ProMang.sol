// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";




contract DevairToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("DevToken", "DVT") {
        _mint(msg.sender, initialSupply);
    }

}

contract ProMang {

    using SafeERC20 for IERC20;

    // What does each property have. 
    // Name of the property, 
    // Type of the propery (houses, cars)
    // Id of the property, to help to know wich property was added first.
    error NOT_THE_OWNER();

    address tokenAddress;

    address public owner;

    // address public buyer;

    struct Property{
        string name;
        string proType;
        uint256 prices;
        uint8 id;
        bool forSale;
        address currentOwner;

    }

    uint8 proId = 1;

    Property[] public properties;

    modifier onlyOwner() {
         _onlyOwner();
         _;
     }
 
     function _onlyOwner() internal {
         if (owner != msg.sender) {
             revert NOT_THE_OWNER();
         }
    }

    // modifier onlyBuyer() {
    //     require(msg.sender == buyer, "owner can't be buyer");
    //     _;
    // }
    

    // mapping(address => uint256) balance;
    // mapping(address => mapping (address => uint256)) allowance;

    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
        owner = msg.sender;
    }

    function createProperty(string memory _name, string memory _proType,uint256 _prices) external {

        Property memory newProperty = Property({name: _name , proType: _proType, prices: _prices, id:proId , forSale: false, currentOwner: msg.sender});
        // payment[msg.sender] = Property({name: _name , proType: _proType, Id:pro_Id });

        properties.push(newProperty);
        proId ++;
        
    }

    function rmvProperty(uint8 _index)external {
        require(_index < properties.length, "Index out of bonds");
        require(properties[_index].currentOwner == msg.sender, "Not property owner");

        for (uint256 i = _index; i < properties.length - 1; i++) {
            properties[i] = properties[i + 1];
        }

        properties.pop();   //to learn more on arrays, and remove, arrays, invest in them.
        // Property memory removeProperty = Property({name: _name , proType: _proType, Id:pro_Id })

    }

    function getAllProperties() external view returns(Property[] memory){
        return properties;

    }

    function setPropertyForSale(uint8 _index) external  returns(bool){
        require(_index < properties.length, "Index out of bonds");
        require(properties[_index].currentOwner == msg.sender, "not property owner");

        properties[_index].forSale = true;
        return properties[_index].forSale;

    }

    // function allowance(address _owner, address _buyer) external view  {
    //     allowance[_owner][_spender];
    // }

    // function approve(address _buyer, uint256 _amount) external  {
    //     buyer = _buyer;
    //     require(_buyer != address(0), "can't transfer to address zero");
    //     allowance[msg.sender][_buyer] = _amount;
    // }

   
    // function payForProperty(address _buyer, uint256 _amount, uint8 _index) external onlyBuyer payable {
    //     buyer = _buyer;
    //     require(_index < properties.length, "Index out of bonds");

    //     Property storage p = properties[_index];
    //     require(p.forSale);
    //     uint256 price = p.prices;

    //     IERC20(token_address).safeTransferFrom(msg.sender, owner , price);
    //     p.forSale = false;

    //     require(properties[_index].forSale == true);


    // }

    function buyProperty(uint8 _index) external {
        require(_index < properties.length, "Index out of bounds");

        Property storage p = properties[_index];
        require(p.forSale, "not for sale");
        require(p.currentOwner != msg.sender, "Owner cnat buy own property");

        uint256 price = p.prices;
        address seller = p.currentOwner;

        IERC20(tokenAddress).safeTransferFrom(msg.sender, seller, price);

        p.currentOwner = msg.sender;
        p.forSale = false;

    }

   



}