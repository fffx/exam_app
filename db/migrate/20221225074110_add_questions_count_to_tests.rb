class AddQuestionsCountToTests < ActiveRecord::Migration[7.0]
  def change
    add_column :tests, :questions_count, :integer
  end
end
