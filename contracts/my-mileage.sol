// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.22 <0.9.0;

/// @title マイレージコントラクト
/// @dev Solidity勉強用コントラクト。
contract MyMileage {
    // コメントを表す構造体
    struct Comment {
        string comment;
        address owner;
        address[] lovedUsers;
    }

    // Javaとかで言うメンバ。
    // ここで保持するものはstorageで保存される。
    // ⇒つまりブロックチェーン上で保存される。
    Comment[] comments;

    /// @notice コメントが追加された際に発生するイベントです。
    /// @param comment コメント（文字列）
    /// @param owner コメントを書き込んだユーザーのアドレス
    event NewComment(string comment, address owner);
    event UpdatedComment();

    /// @notice コメントを追加します。
    /// @dev 引数で受けたコメントから構造体を生成し、storageのComment[]に追加します。追加に成功した場合はNewCommentイベントを発火します。
    /// @param _comment 追加するコメント（文字列）
    function addComment(string calldata _comment) external payable {
        address[] memory lovedUsers; // ローカル変数はmemoryで保持するため、storageとは違いブロックチェーン上には保存されない。
        comments.push(Comment(_comment, msg.sender, lovedUsers));

        emit NewComment(_comment, msg.sender); // イベント発火
    }

    /// @notice 新規にいいね！をしたユーザーか判定します。
    /// @dev すでにいいね！をしたユーザーの場合は何もしない。
    /// @param _id コメントのID
    modifier newLovedUser(uint256 _id) {
        address[] memory lovedUsers = comments[_id].lovedUsers;
        for (uint256 i = 0; i < lovedUsers.length; i++) {
            require(lovedUsers[i] != msg.sender); // すでにいいね！したユーザーである場合は関数を抜ける。
        }
        _;
    }

    /// @notice コメントにいいね！します。
    /// @dev 指定されたコメントにいいね！します。
    /// @param _id コメントのID
    function loveComment(uint256 _id) external payable newLovedUser(_id) {
        comments[_id].lovedUsers.push(msg.sender);
        emit UpdatedComment();
    }

    /// @notice すべてのコメントを取得します。
    /// @dev storageに保持しているすべてのコメントを取得します。
    /// @return _comments コメント構造体の配列
    function getComments() external view returns (Comment[] memory _comments) {
        return comments;
    }
}
