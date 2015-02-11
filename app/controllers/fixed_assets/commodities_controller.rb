class FixedAssets::CommoditiesController < AdministrationController
  # GET /fixed_assets/commodities
  def index
    @commodities = current_company.commodities
      .search_like(search_params)
      .order(order_params)
  end

   # GET /fixed_assets/commodities/1
  def show
    render :edit
  end

  # GET /fixed_assets/commodities/new
  def new
    @commodity = current_company.commodities.build
  end

  # PATCH/PUT /fixed_assets/commodities/1
  def update
    if @commodity.update_by(commodity_params, current_user)
      redirect_to edit_commodity_path(@commodity), notice: 'Hyödyke päivitettiin onnistuneesti.'
    else
      render :edit
    end
  end

  # GET /fixed_assets/commodities/1/edit
  def edit
  end

  # POST /fixed_assets/commodities
  def create
    @commodity = current_company.commodities.build(commodity_create_params)

    if @commodity.save_by current_user
      redirect_to edit_commodity_path(@commodity), notice: 'Hyödyke luotiin onnistuneesti.'
    else
      render :new
    end
  end

  # GET /fixed_assets/commodities/1/select_purchase_order
  def select_purchase_order
    @purchase_orders = current_company.purchase_orders.limit(50)
    @purchase_orders = @purchase_orders.search_like params_search
    @purchase_orders = @purchase_orders.order("#{sort_column} #{sort_direction}")
  end

  # GET /fixed_assets/commodities/1/select_voucher
  def select_voucher
    @vouchers = current_company.vouchers.limit(50)
    @vouchers = @vouchers.search_like params_search
    @vouchers = @vouchers.order("#{sort_column} #{sort_direction}")
  end

  private

    # Allow only these params for update
    def commodity_params
      params.require(:fixed_assets_commodity).permit(
        :name,
        :description,
        :amount,
        :purchased_at,
        :activated_at,
        :planned_depreciation_type,
        :planned_depreciation_amount,
        :btl_depreciation_type,
        :btl_depreciation_amount,
        :status,
        :cost_centre,
        :target,
        :project
      )
    end

    # Allow only these params for create
    def commodity_create_params
      params.require(:fixed_assets_commodity).permit(
        :name,
        :description
      )
    end

    def searchable_columns
      [
        :name,
        :description
      ]
    end

    def sortable_columns
      searchable_columns
    end

    def find_resource
      @commodity = current_company.commodities.find(params[:id])
    end
end

