import "./Ownable.sol";
pragma solidity 0.5.12;

contract Destroyable is Ownable {
    function close() public {
        selfdestruct(owner);
    }
}

