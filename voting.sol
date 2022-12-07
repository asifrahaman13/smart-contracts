// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Voting{
    
    address public manager;
    address [] public voters;
    address [] public members;
    mapping(address=>uint) res;

    constructor() {
        manager=msg.sender;
    }

    function alreadyVoted() view public returns(bool){
        for(uint i=0;i<voters.length;i++){
            if(voters[i]==msg.sender){
                return true;
            }
        }
        return false;
    }

    function alreadyStanded() view public returns(bool){
        for(uint i=0;i<members.length;i++){
            if(members[i]==msg.sender){
                return true;
            }
        }
        return false;
    }

    function enterToStand() public{
        require(msg.sender!=manager,"Manager cannot stand in the election");
        require(!alreadyStanded(),"One can refgister onluy oncee");
        members.push(msg.sender);
    }


    function enterToVote() public{
        require(msg.sender!=manager,"Mangager himself cannot vote");
        require(!alreadyVoted(),"Sorry one cannot enter twice");
        voters.push(msg.sender);
    }

    function showMembers()public view returns(address[] memory){
        return members;
    }

    function showVoters() public view returns(address[] memory){
        return voters;
    }

    function vote(uint _x)public{
        require(msg.sender!=manager,"Mangager himself cannot vote");
        require(!alreadyVoted(),"You already voted once");
        res[members[_x]]++;
    }

    function declareWinner()public view returns(address){
        require(msg.sender==manager,"Only the manager can declare the winner");
        uint ans=0;
        address winner;
        for(uint i=0;i<members.length;i++){
            if(res[members[i]]>ans){
                ans=res[members[i]];
                winner=members[i];
            }
        }
       return winner;
    }
}