class TwitterAccountsController < ApplicationController
  def index
    @account_name = params[:account_name]

    @tweets = []

    if @account_name.present?
      @tweets = TwitterAccount.client.user_timeline(@account_name.strip)
    end
  end

  def compare
    @first_account_name = params[:first_account_name]
    @second_account_name = params[:second_account_name]
    
    @fa_fol_ids = []
    @sa_fol_ids = []

    if @first_account_name.present? and @second_account_name.present?
      @fa_fol_ids = TwitterAccount.client.follower_ids(@first_account_name.strip).attrs[:ids]
      @sa_fol_ids = TwitterAccount.client.follower_ids(@second_account_name.strip).attrs[:ids]
    end

    @common_follower_ids = (@fa_fol_ids & @sa_fol_ids)

    # cut to 30 so we dont make alot of api calls
    @common_followers = @common_follower_ids.first(30).map do |fid|
      user = TwitterAccount.client.user(fid)
      "#{user.screen_name} - #{user.name}"
    end

  end

end
