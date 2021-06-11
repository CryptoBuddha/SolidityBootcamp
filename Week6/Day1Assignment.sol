pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {
      address creator;
      string name;
      uint age;
      uint height;
      bool senior;
    }

    Person[] public people;

    function createPerson(string memory name, uint age, uint height) public {
        //This creates a person
        Person memory newPerson;
        newPerson.creator = msg.sender;
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
    }
    function insertPerson(Person memory newPerson) private {
        people.push(newPerson);
    }
    function getPerson(uint index) public view returns(address creator, string memory name, uint age, uint height, bool senior){
        return (people[index].creator, people[index].name, people[index].age, people[index].height, people[index].senior);
    }

}