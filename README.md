# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# テーブル設計

## users テーブル

| Column              | Type   | Options     |
| ------------------- | ------ | ----------- |
| nickname            | string | null: false |
| email               | string | null: false |
| password            | string | null: false |
| last_name           | string | null: false |
| first_name          | string | null: false |
| last_name_kana      | string | null: false |
| first_name_kana     | string | null: false |
| user_birthday_year  | string | null: false |
| user_birthday_month | string | null: false |
| user_birthday_day   | string | null: false |

### Association

- has_many :items
- has_many :buys

## items テーブル

| Column               | Type       | Options     |
| -------------------- | -----------| ----------- |
| item_name            | text       | null: false |
| item_text            | text       | null: false |
| item_category        | string     | null: false |
| item_sale_status     | string     | null: false |
| item_shipping_fee    | string     | null: false |
| item_shipping_area   | string     | null: false |
| days_to_ship         | string     | null: false |
| item_price           | string     | null: false |
| user                 | references | null: false, foreign_key: true |


### Association

- has_one :buy
- belongs_to :user


## buys テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- has_one :address
- belongs_to :user
- belongs_to :item

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     |                                |
| prefectures   | string     | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| buliding_name | string     |                                |
| tel           | string     | null: false                    |
| buy           | references | null: false, foreign_key: true |

### Association

- belongs_to :buy