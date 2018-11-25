class RemoveConsumerFromCounter < ActiveRecord::Migration[5.2]
  def change
     remove_reference :counters, :consumer, index:true
  end
end
