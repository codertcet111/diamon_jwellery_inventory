class ChangeShapeColorClarityType < ActiveRecord::Migration[5.2]
  def change
    change_column :stocks, :shape,'integer USING CAST(shape AS integer)'
    change_column :stocks, :color, 'integer USING CAST(color AS integer)'
    change_column :stocks, :clarity, 'integer USING CAST(clarity AS integer)'
  end
end
