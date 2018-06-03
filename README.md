## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :members
- has_many :groups, through: :members
- has_many :messages


## groupsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|user_id|reference|null: false, foreign_key: true|

### Association
- has_many  :members
- has_many :users, through: :members
- has_many :messages


## membersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|reference|null: false, foreign_key: true|
|group_id|reference|null: false, foreign_key: true|


### Association
- belongs_to :group
- belongs_to :user


## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|image|string|null: false|s
|user_id|reference|null: false ,foreign_key: true|
|group_id|reference|null: false ,foreign_key: true|


### Association
- belongs_to :groups
- belongs_to :users

