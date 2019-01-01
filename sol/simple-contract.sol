pragma solidity 0.5.0;

contract SimpleDemo {
  address payable creater;
  string private _store;

  constructor () public {
    creater = msg.sender;
  }

  function set (string memory _input) public {
    _store = _input;
  }

  function get () public view returns (string memory output) {
    return _store;
  }

  function kill () public {
    require(msg.sender == creater);
    selfdestruct(creater);
  }
}
