class Pay2goController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    result = nil
    ActiveRecord::Base.transaction do
      @payment = Payment.find_and_process(json_data)
      result = @payment.save
    end

    flash[:alert] = t("registration.error.failed_pay") unless result

    if @payment.paid?
     # send paid email
    end

    redirect_to order_path(@payment.order)
  end

  def notify
    result = nil
    ActiveRecord::Base.transaction do
      @payment = Payment.find_and_process(json_data)
      result = @payment.save
    end

    if result
      render :text => "1|OK"
    else
      render :text => "0|ErrorMessage"
    end
  end

  private

  def json_data
    JSON.parse(params['JSONData'])
  end
end