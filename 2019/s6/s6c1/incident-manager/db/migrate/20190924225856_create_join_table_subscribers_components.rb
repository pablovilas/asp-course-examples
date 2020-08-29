class CreateJoinTableSubscribersComponents < ActiveRecord::Migration[6.0]
  def change
    create_join_table :subscribers, :components do |t|
      # t.index [:subscriber_id, :component_id]
      # t.index [:component_id, :subscriber_id]
    end
  end
end
