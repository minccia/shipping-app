class TableEntriesController < ApplicationController
  before_action :require_admin

  def create 
    table_type = self.discover_table_type
    table_id = self.decide_which_table_id
    @table_entry = TableEntry.new new_table_entry_params

    if @table_entry.save 
      flash.notice = t 'price_added_to_table_with_success'
      return redirect_to transport_modality_url(table_type.find(table_id).transport_modality.id)
    end

    flash.notice = t 'price_not_added'
    return redirect_to transport_modality_url(table_type.find(table_id).transport_modality.id)
  end

  private 

  def new_table_entry_params 
    params.require(:table_entry).permit(
      :first_interval, :second_interval, :price,
      :weight_price_table_id, :distance_price_table_id,
      :transport_modality_id
    )
  end

  def discover_table_type
    params[:table_entry][:weight_price_table_id].nil? ? DistancePriceTable : WeightPriceTable
  end

  def decide_which_table_id
    parameters = params[:table_entry]
    
    if parameters[:weight_price_table_id].nil?
      return parameters[:distance_price_table_id]
    end
    parameters[:weight_price_table_id]
  end
  
end