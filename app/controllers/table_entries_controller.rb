class TableEntriesController < ApplicationController
  before_action :require_admin
  before_action :discover_entry_associated_table, only: %i[create]
  before_action :fetch_entry, only: %i[edit update]

  def create 
    @table_entry = TableEntry.new new_table_entry_params

    if @table_entry.save 
      flash.notice = t 'price_added_to_table_with_success'
      return redirect_to transport_modality_url(@table.transport_modality.id)
    end
    flash.notice = t 'price_not_added'
    return redirect_to transport_modality_url(@table.transport_modality.id)
  end

  def edit; end

  def update 
    if @table_entry.update new_table_entry_params
      flash.notice = t 'price_updated_with_success'
      return redirect_to transport_modality_url(@table_entry.fetch_table.transport_modality.id)
    end
    flash.now.notice = t 'price_not_updated'
    render :edit, status: :unprocessable_entity
  end

  private 

  def fetch_entry 
    @table_entry = TableEntry.find params[:id]
  end

  def new_table_entry_params 
    params.require(:table_entry).permit(
      :first_interval, :second_interval, :price,
      :weight_price_table_id, :distance_price_table_id,
      :transport_modality_id
    )
  end

  def discover_entry_associated_table
    if params[:table_entry][:weight_price_table_id].nil?
      @table = DistancePriceTable.find params[:table_entry][:distance_price_table_id] 
    else 
      @table = WeightPriceTable.find params[:table_entry][:weight_price_table_id]
    end
  end
  
end