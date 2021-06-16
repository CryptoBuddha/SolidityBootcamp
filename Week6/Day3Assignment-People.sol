import  "./Ownable.sol";
import "./Destroyable.sol";
pragma solidity 0.5.12;

contract People is Ownable, Destroyable{
    
   
    
    uint public balance;
    
    address[] private creators;
    
    event personCreated(string name, bool senior);
    event personDeleted(string name, bool senior, address deletedBy);
    event personUpdated(string oldName, uint oldAge, uint oldHeight, bool oldSenior, string newName, uint newAge, uint newHeight, bool newSenior);
    
   

    struct Person {
      uint id;
      string name;
      uint age;
      uint height;
      bool senior;
    }
    
 
    
    modifier costs(uint cost) {
        require(msg.value >= cost);
        _;
    }

    mapping (address => Person) private people;

    function createPerson(string memory name, uint age, uint height) internal {
        require(age < 150, "Age needs to be below 150");
        balance += msg.value;
        //This creates a person
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;

        if(age >= 65){
           newPerson.senior = true;
       }
       else{
           newPerson.senior = false;
       }

        insertPerson(newPerson);
        creators.push(msg.sender);
        //people[msg.sender] == newPerson;
        assert(
            keccak256(
                abi.encodePacked(
                    people[msg.sender].name,
                    people[msg.sender].age,
                    people[msg.sender].height,
                    people[msg.sender].senior
                    )
                )
                == 
                keccak256(
                    abi.encodePacked(
                        newPerson.name,
                        newPerson.age,
                        newPerson.height,
                        newPerson.senior
                        )
                    )
                );
                //emit personCreated(newPerson.name, newPerson.senior);
    }
    function insertPerson(Person memory newPerson) private {
        address creator = msg.sender;
        if (people[creator].age != 0) {
            //asign current old information to their respective variables
            string memory oldName = people[creator].name;
            uint oldAge = people[creator].age;
            uint oldHeight = people[creator].height;
            bool oldSenior = people[creator].senior;
            
            //update people mapping with new Person struct
            people[creator] = newPerson;
            emit personUpdated(oldName, oldAge, oldHeight, oldSenior, newPerson.name, newPerson.age, newPerson.height, newPerson.senior);
        }
        else {
            people[creator] = newPerson;
            emit personCreated(newPerson.name, newPerson.senior);
        }
    }
    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    function deletePerson(address creator) internal onlyOwner{
        //require(msg.sender == owner);
        string memory name = people[creator].name;
        bool senior = people[creator].senior;
        delete people[creator];
        assert(people[creator].age == 0);
        emit personDeleted(name, senior, msg.sender);
    }
    function getCreator(uint index) public view onlyOwner returns(address){
        //require(msg.sender == owner, "Caller needs to be owner");
        return creators[index];
    }

}