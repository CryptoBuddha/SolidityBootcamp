import "./People.sol";

pragma solidity 0.5.12;

contract Workers is People {
    
    mapping (address => uint) public salary;
    
    function createWorker(string memory name, uint age, uint height, uint salaryAmount) public {
        require(age < 75, "You are too old to be working! Retire!");
        address worker = msg.sender;
        createPerson(name, age, height);
        salary[worker] = salaryAmount;
    }
    
    function fireWorker(address creator) public{
        deletePerson(creator);
        salary[creator] = 0;
    }

}
