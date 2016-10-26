# Betacamp

這裡是上課時用購物網站做主題示範的程式碼

- Ruby 2.x 以上
- Rails 5.0.0.1
- 執行 `rake db:reset` 可以重建資料
- 參考 db/seeds.rb 可得管理者帳號密碼
- 建議 clone 整個 repository 下去，可以讀一下各個 commit

請搭配 ihower 老師實戰聖經服用，主要範圍：

- 路由 [https://ihower.tw/rails4/routing.html]
- ActionController [https://ihower.tw/rails4/actioncontroller.html]
- ActiveRecord: Query Interface [https://ihower.tw/rails4/activerecord-query.html]
- ActiveRecord: Migration [https://ihower.tw/rails4/migrations.html]
- ActiveRecord: Association [https://ihower.tw/rails4/activerecord-relationships.html]
- ActiveRecord: Validation & Callback [https://ihower.tw/rails4/activerecord-lifecycle.html]
- ActiveRecord: Others [https://ihower.tw/rails4/activerecord-others.html]
- ActiveView [https://ihower.tw/rails4/actionview.html]

## Routes

示範幾種定義路由規則的方式

### Nested Resources

購網站的產品型錄，由「分類」-「產品」組在，這裡我們用巢狀 resource 來實作它

- /categories/123 瀏覽 id=123 的產品分類（顯示該分類下的產品列表）
- /categories/123/products/987 瀏覽 id=987 的產品詳細資訊（該產品屬於分類123)

https://github.com/cloud1985xp/betacamp/commit/a6fa93e64d816d42e66352c49754c3e8835f80e1

### Http Verb

追加幾個單純的頁面，像是「關於本站」、「聯絡我們」，這裡直接用 http verb 指定路徑來定義

- /contact 「聯絡我們」的頁面
- /about 「關於本站」的頁面

https://github.com/cloud1985xp/betacamp/commit/3a4f80f928f73fada1cef89c981ce0db81a3da74

### Use Namespace

整個管理後台，我們直接獨立出一個 namespace，在裡面定義各項管理功能的路由

- /admin/ 後台首頁
- /admin/users 使用者管理
- /admin/categories 分類管理
- /admin/products 產品管理
- etc

https://github.com/cloud1985xp/betacamp/commit/da39af7e099ce92ba4e4c73afbabdc6a742e5b47

## ActionController

### Use rescue_from

當發生像是 Routing Error(使用者連向錯誤的網址) 或 ActiveRecord::RecordNotFound (資料庫裡找不到對應資料時)
我們可以在 Controller 層直接攔截住這類的錯誤，並將畫面顯示為 404

https://github.com/cloud1985xp/betacamp/commit/a191322a7780162a3e70c4ef9c2ca159a1508ff9

### Use Cookies

這個範例簡單利用 cookies 紀錄使用者瀏覽某產品的時間，
藉此比對該產品最近更新的時間，以判斷畫面上要顯示 「已看過(viewed)」或是「新的(new)」

https://github.com/cloud1985xp/betacamp/compare/feature/day1...feature/day1-cookie-example?expand=1

### Friendly ID

簡單實作出帶有產品名稱的 url 格式，例如

/categories/123/products/987-PlayStation4

https://github.com/cloud1985xp/betacamp/compare/feature/day1...feature/day1-friendly-id?expand=1

## ActiveRecord

### Scoped Query

將原本的 query 條件

- 「啟用的分類」： Category.where(enabled: true) ，與
- 「販售中的商品」： Product.where(active: true)

用 scope 取代

https://github.com/cloud1985xp/betacamp/compare/feature/day1-rescue-from...feature/day2-query-scope?expand=1

當之後又要修改「販售中商品」的定義時，只要修改 scope 即可
例如修改成「販售中」不僅要 active: true 還要另加一個「上架日期」(shelved_on) 來做為條件

https://github.com/cloud1985xp/betacamp/compare/feature/day2-query-scope...feature/day2-product-shelved-on?expand=1


### Simple Cart, Many to Many Association

實作購物車基本功能，將商品放入購物車

- 此時 Cart, CartItem & Product 之間是 many to many 的關聯
- 範例中故意在 association name 上做一些調整，請參考註解

https://github.com/cloud1985xp/betacamp/commit/37582248e5a93ffcbe2b016f32771c776db62334

### Self-Reference

若要讓分類可以為做多階層的設計(即分類可以有子分類)，就用到 self-reference 的關聯設計

https://github.com/cloud1985xp/betacamp/commit/1050bf2d69afb87cb5de5371f12f53da89893494

### Counter Cache

示範用 counter cache 做到紀錄各個分類下有多少的商品
順更簡單利用這個 counter 的值來判斷選單是否可以被點擊（若分類下沒有商品就不用產生連結）

https://github.com/cloud1985xp/betacamp/commit/76228342af5d5366b9a786ad979e9eccf19d94ca

### Nested Fields: Edit Order

加上訂單 model，也是 many to many 的關聯
並利用 nested_form_fields [https://github.com/ncri/nested_form_fields] 這個 gem 來實作後台的訂單編輯
因為編輯 nested fields 若要可以動態增加/刪除子欄位 (order items)，需要搭配 javascript 來控制表單的 DOM
這裡 nested_form_fields 可以幫助我們輕鬆完成

https://github.com/cloud1985xp/betacamp/commit/19192064eec6f1fca513f94e3a3f2342c01b9f10

### Polymorphic: Commentable

讓 Category 跟 Product 都是可以被增加評論的
藉由多型的功能，實作上可以用一個 Comment Model 來存就好

https://github.com/cloud1985xp/betacamp/commit/dad708931e389bb6974aa8a37a206edaea676ad4

### Use #includes

在一些 Collection 的 query 加上 includes 所需的關聯，來避免掉 N+1 的效能問題

https://github.com/cloud1985xp/betacamp/commit/e053c935943e671b5e0161acc0cd6a051f2e6ee9

### STI

這個例子是為 Product 加上供應商（Provider），但又需區分「本地供應商」(LocalProvider) 與「國外供應商」(ForeignProvider)
於是就利用 STI 設計了父類別 - Provider 與兩個子類別 LocalProvider & ForeignProvider，共用單一張資料表來完成繼承設計

https://github.com/cloud1985xp/betacamp/commit/f6203e249c41deba0f16aeaef187b8515de6df6c

### Callback and Dirty Object

利用 callback 與 dirty object 提供的 changes 相關方法，來完成紀錄訂單被修改的情況

https://github.com/cloud1985xp/betacamp/commit/862875080734ad9f2c718a1eb1075afa8032c25d

## ActionView

### Extract Partial

之前有很多 view 都是 copy paste 的，來 DRY 一下

https://github.com/cloud1985xp/betacamp/commit/b627b6ddee2bf542181f0c737700967357393f66

### Useful Helpers

- 使用 #truncate 讓產品列表的 grid 整齊一些
- 使用 #content_for 來實作 opengraph 或安插 javascript

https://github.com/cloud1985xp/betacamp/commit/5c36c84048023923e3c0811ca48df664fd5168f6


## Background Job

- 透過背景工作，來匯出所有產品資料，並將匯出的檔案寄信給自己
- 這裡採用的 Adapter 是 Sidekiq

https://github.com/cloud1985xp/betacamp/commit/09f997656c9da340e2bd2da73ad0e00cdfcc2721

記得要

- 安裝 redis-server
- 在 commandline 把 sidekiq 跑起來

```
bundle exec sidekiq
```

## Payment

完成購物網站的結帳功能，串 pay2go 的金流服務
記得先去申請 sandbox 帳號

https://github.com/cloud1985xp/betacamp/commit/14d086f56242b822fd7855b64b9378f8013b610b


## joins vs includes on cross table condition

進一步介紹 AR 在 joins 與 includes 的行為，尤其是跨 table 條件的時候

```
rake db:reset
rake example:data
```

visit http://localhost:3000/example