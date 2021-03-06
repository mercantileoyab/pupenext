class Administration::CustomerTransportsController < AdministrationController

  def index
    @transports = current_company.customer_transports
  end

  def show
    render :edit
  end

  def new
    @transport = current_company.customer_transports.new
    render :edit
  end

  def edit
  end

  def create
    @transport = current_company.customer_transports.new transport_params

    if @transport.save
      redirect_to customer_transports_url
    else
      render :edit
    end
  end

  def update
    if @transport.update(transport_params)
      redirect_to customer_transports_url
    else
      render :edit
    end
  end

  def destroy
    @transport.destroy
    redirect_to customer_transports_url
  end

  private

    def find_resource
      @transport = current_company.customer_transports.find params[:id]
    end

    def transport_params
      params.require(:customer_transport).permit(
        :transportable_id,
        :hostname,
        :password,
        :path,
        :username,
      )
    end
end
