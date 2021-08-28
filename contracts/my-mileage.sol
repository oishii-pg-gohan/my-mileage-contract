// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.22 <0.9.0;

contract MyMileage {
    struct Comment {
        string comment;
        address owner;
        address[] lovedUsers;
    }

    Comment[] comments;

    event NewComment(string comment, address owner);
    event UpdatedComment();

    function addComment(string calldata comment) external payable {
        address[] memory lovedUsers;
        comments.push(Comment(comment, msg.sender, lovedUsers));

        emit NewComment(comment, msg.sender);
    }

    modifier newLovedUser(uint256 _id) {
        address[] memory lovedUsers = comments[_id].lovedUsers;
        for (uint256 i = 0; i < lovedUsers.length; i++) {
            require(lovedUsers[i] != msg.sender);
        }
        _;
    }

    function loveComment(uint256 _id) external payable newLovedUser(_id) {
        comments[_id].lovedUsers.push(msg.sender);
        emit UpdatedComment();
    }

    function getComments() external view returns (Comment[] memory _comments) {
        return comments;
    }
}
