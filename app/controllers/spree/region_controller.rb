module Spree
  class RegionController < StoreController
    def set
      @currency = supported_currencies.find { |currency| currency.iso_code == region_to_currency(params[:region]) }

      if current_order.present?
        # Make sure that we update the current order, so the currency change is reflected.
        current_order.update_attributes!(currency: @currency.iso_code)
        # Make sure that we update taxes
        # https://github.com/spree/spree/blob/bc0c3679fb137394c59cfe5651ffe561ee2e4722/core/app/models/spree/order.rb#L285
        current_order.create_tax_charge!
        current_order.update!
      end

      if Spree::Config[:allow_currency_change]
        session[:region] = params[:region]
        session[:currency] = region_to_currency(params[:region])
      end
      respond_to do |format|
        format.json { render json: !@currency.nil? }
        format.html do
          # We want to go back to where we came from!
          redirect_back_or_default(root_path)
        end
      end
    end
  end
end