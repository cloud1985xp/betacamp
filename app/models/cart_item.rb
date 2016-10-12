class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item, class_name: 'Product'
  # 我故意想將關聯名稱取為 item，這時 activerecord 依慣例會:
  # 1. 試圖去找對應名稱為 Item 的 class -> (x) 會找不到 (x)
  # 2. 關聯的 foreign_key 會用 'item_id' -> (o) ok! 資料表裡的欄位的確是這樣命名
  # 所有的部分，因為並沒有這樣的 class，所以這裡要傳入 class_name 來指定它正確的名稱(Product)

  delegate :name, :price, to: :item

  def subtotal
    quantity * item.price
  end
end
