pragma solidity 0.5.0;

contract SimpleDemo {

  uint cooldownTime = 1 days;

  event NewRed_Packet(uint zombieId, string command, bool random, uint8 share, uint16 value);

  struct Red_Packet {
    // address owner;    // 发红包的人
    string command;   // 口令
    bool random;      // 是否是随机红包
    uint8 share;      // 红包份数
    uint16 value;     // 红包总额
    uint16 balance;   // 红包余额
    uint32 readyTime; // 冷却时间
  }

  Red_Packet[] public redpackets;

  mapping (uint => address) public redpackToOwner;
  mapping (address => uint) ownerRedpackCount;

  // 创建红包
  function createRedpack(string _command, bool _random, uint8 _share, uint16 _value) public payable {
    //require(_value >= _share * 0.01);
    uint id = redpackets.push(Red_Packet(_command, _random, _share, _value, _value, uint32(now + cooldownTime))) - 1;
    redpackToOwner[id] = msg.sender;
    ownerRedpackCount[msg.sender]++;
    NewRed_Packet(id, _command, _random, _share, _value);
  }
}
