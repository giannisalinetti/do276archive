# encoding: UTF-8

class Item < ActiveRecord::Base
    self.table_name = "Item"
     
    def done
        self[:done] == "\x01" ? true : false  
    end

    def done=(new_done)
        self[:done] = new_done ? "\x01" : "\x00"  
    end
end

