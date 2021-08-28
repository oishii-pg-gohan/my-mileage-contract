# Solidity勉強用リポジトリ  
Ethereum上に乗せるコントラクトの実装を勉強。  
別リポジトリの[my-mileage](https://github.com/oishii-pg-gohan/my-mileage)と連携。

## function
### addComment(string _comment)
新規コメントを追加する。  
追加したコメントはstrorage上に保存する。


### loveComment(uint256 _id)
コメントといいね！を紐づける。  
紐づけ内容はstorageに保存する。  
Web3のサンプル同様キャッチーなネーミングにしました。  
いずれはこのいいね！がFTの役割になる？ことを想定。


### getComments()
保存されている全コメントを取得する。


## event
### NewComment(string comment, address owner)
新規コメントが追加された際に発生するイベント。


### UpdatedComment()
コメントが更新された際に発生するイベント。  
※コメントの修正機能はない。  
　現状発生するのはコメントといいね！の紐づけが発生した場合のみ。
