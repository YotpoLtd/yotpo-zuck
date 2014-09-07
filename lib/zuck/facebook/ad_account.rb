module Zuck
  class AdAccount < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/adaccount

    fields :id,
           :account_id,
           :account_status,
           :account_groups,
           :age,
           :agency_client_declaration,
           :amount_spent,
           :balance,
           :business_city,
           :business_country_code,
           :business_name,
           :business_state,
           :business_street2,
           :business_street,
           :business_zip,
           :capabilities,
           :currency,
           :daily_spend_limit,
           :is_personal,
           :name,
           :spend_cap,
           :timezone_id,
           :timezone_name,
           :timezone_offset_hours_utc,
           :tos_accepted,
           :users,
           :vat_status

    update_fields :name

    list_path   'me/adaccounts'
    connections :ad_campaign_groups, :ad_campaigns, :ad_creatives, :ad_groups

    def self.all(graph = Zuck.graph)
      super(graph)
    end

    def self.create(data, graph = Zuck.graph)
      super(graph, data)
    end
  end
end
