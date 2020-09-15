require 'pry'
class CashRegister   
    attr_writer :items
    attr_accessor :total, :discount

    def initialize(discount=nil, total=0)
        @total = total
        @discount = discount
        @items = {}
    end

    def add_item(title, price, quantity=1.0)
        @items[title] = {
            :p => price,
            :qty => quantity
        }
        @total += price * quantity
    end

    def apply_discount
        if @discount
            @total = (@total - @discount / 100.0 * @total.to_f)
            "After the discount, the total comes to $#{@total.to_i}."
        else
            "There is no discount to apply."
        end
    end

    def void_last_transaction
        last_item = @items.keys.last
        diff = @items[last_item][:p].to_f * @items[last_item][:qty].to_f
        @total -= diff
        @items = @items.delete(last_item)
    end

    def items
        @items.map {|title, info| [title] * info[:qty]}.flatten
    end
end
