class TwitterAccountsController < ApplicationController
  def index
    @account_name = params[:account_name]

    @tweets = []

    if @account_name.present?
      @tweets = TwitterAccount.client.user_timeline(@account_name)
    end
  end
end
