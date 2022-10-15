class TableEntriesController < ApplicationController
  before_action :require_admin
  before_action :pick_correct_table_from_params, only: %i[create]
  before_action :fetch_entry, only: %i[edit update]

  def create 
    @table_entry = TableEntry.new new_table_entry_params

    if @table_entry.save 
      flash.notice = t 'entry_added_to_table_with_success'
      return redirect_to transport_modality_url(@table.transport_modality.id)
    end
    flash.notice = t 'entry_not_added'
    return redirect_to transport_modality_url(@table.transport_modality.id)
  end

  def edit; end

  def update 
    if @table_entry.update new_table_entry_params
      flash.notice = t 'entry_updated_with_success'
      return redirect_to transport_modality_url(@table_entry.fetch_table.transport_modality.id)
    end
    flash.now.notice = t 'entry_not_updated'
    render :edit, status: :unprocessable_entity
  end

  private 

    def fetch_entry 
      @table_entry = TableEntry.find params[:id]
    end
  
    def new_table_entry_params 
      params.require(:table_entry).permit(
        :first_interval, :second_interval, :value,
        :weight_price_table_id, :distance_price_table_id,
        :freight_table_id, :transport_modality_id
      )
    end
  
    def pick_correct_table_from_params
      parameters = params[:table_entry]
      
      if parameters[:weight_price_table_id].nil? && parameters[:freight_table_id].nil?
        @table = DistancePriceTable.find parameters[:distance_price_table_id] 

      elsif parameters[:distance_price_table_id].nil? && parameters[:freight_table_id].nil? 
        @table = WeightPriceTable.find parameters[:weight_price_table_id]

      else  
        @table = FreightTable.find parameters[:freight_table_id]
      end
    end
  
end