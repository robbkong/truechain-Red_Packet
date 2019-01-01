pragma solidity 0.5.0;

contract SimpleDemo {

  struct Red_Packet {
    address owner;    // 发红包的人
    string command;   // 口令
    bool random;      // 是否是随机红包
    uint8 share;      // 红包份数
    uint16 value;     // 红包总额
    uint16 balance;   // 红包余额
    uint32 readyTime; // 冷却时间
  }

}
