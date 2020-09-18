
#flags for indexes of the highest array
BUY_DAY = 0
SELL_DAY = 1
PROFIT = 2  

def stock_picker(prices)
  highest = [0,0,0]
  prices.each_with_index do |buy_price, buy_day|  #naming my value/index variables to show how I use them
    prices[buy_day..prices.length].each_with_index() do |sell_price, days_after_buy_day| #avoid sell-before-buy problems with a subset range
      profit = sell_price - buy_price
      if(profit > highest[PROFIT])
        sell_day = buy_day + days_after_buy_day
        highest = [buy_day, sell_day, profit]
     end
    end
  end
  [highest[BUY_DAY], highest[SELL_DAY]] 
  #if I weren't keeping to the project requirements, I would return highest or a formatted string like "Buy on day #{highest[BUY_DAY] and sell on day #{highest[SELL_DAY]} for a profit of #{highest[PROFIT]}."
end

p stock_picker([17,3,6,9,15,8,6,1,10])   #returns [1,4]
p stock_picker([5, 5, 5, 6, 7, 1])       #returns [0,4]
p stock_picker([9, 10, 4, 17])           #returns [2,3]

