class TableEntry < ApplicationRecord
  belongs_to :distance_price_table, optional: true 
  belongs_to :weight_price_table, optional: true
  belongs_to :freight_table, optional: true

  validate :entry_range_must_be_unique
  validates :first_interval, :second_interval, :value, presence: true
  validates :first_interval, :second_interval, :value, numericality: { greater_than_or_equal_to: 0 }

  def fetch_table
    [self.weight_price_table, self.distance_price_table, self.freight_table].find(&:itself)
  end

  private 

    def entry_range_must_be_unique
      first_intervals = fetch_table.table_entries.pluck(:first_interval)
      second_intervals = fetch_table.table_entries.pluck(:second_interval)
      if first_intervals.include?(self.first_interval) || second_intervals.include?(self.second_interval)
        self.errors.add('Já existe uma entrada na tabela com esses intervalos')
      end
    end

end
