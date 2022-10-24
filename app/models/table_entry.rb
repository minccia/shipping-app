class TableEntry < ApplicationRecord
  belongs_to :distance_price_table, optional: true 
  belongs_to :weight_price_table, optional: true
  belongs_to :freight_table, optional: true

  validate :entry_range_is_unique?
  validates :first_interval, :second_interval, :value, presence: true

  def fetch_table
    [self.weight_price_table, self.distance_price_table, self.freight_table].find(&:itself)
  end

  private 

    def entry_range_is_unique?
      first_intervals = fetch_table.table_entries.pluck(:first_interval)
      second_intervals = fetch_table.table_entries.pluck(:second_interval)
      if first_intervals.include?(self.first_interval) || second_intervals.include?(self.second_interval)
        self.errors.add('Já existe uma entrada na tabela com esses intervalos')
      end
    end

end
