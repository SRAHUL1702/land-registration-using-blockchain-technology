// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

contract Land{
 address public government;
    struct sellReq{
        uint lno;
        address s;
    }
 mapping(uint=>bool) govVerify;
 uint public ld;
 uint public alreadyBuy;
 uint public sellRequest;

 mapping(uint=>sellReq) listLand;
 mapping(uint=>address) register;

    constructor(){
         government=msg.sender;
         alreadyBuy=0;
         sellRequest=0;
         ld=0;
    }

    function addLand(uint v) public{
        require(msg.sender==government,"hey you are not government");
        bool check=govVerify[v];
        require(check==false,"Already added");
        govVerify[v]=true;
        register[v]=msg.sender;
    }

    function sellLand (uint l_no) public {
       address v=register[l_no];
       require(msg.sender==v,"hey you are not owner");
       sellReq storage usr=listLand[sellRequest];
       usr.lno=l_no;
       usr.s=msg.sender;
       sellRequest++;
    }

    function buyLand() public payable {
        require(alreadyBuy<sellRequest,"sry not yet");
        sellReq storage u=listLand[alreadyBuy];
        (bool b,)=u.s.call{value:msg.value}("");
        require(b,"failed");
        register[u.lno]=msg.sender;
        alreadyBuy++;
        ld=u.lno;
        
    }
    function showLand() public returns(uint){
        return ld;
    }



}