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
           :tax_id_status

    update_fields :name

    list_path   'me/adaccounts'
    connections :ad_campaign_groups, :ad_campaigns, :ad_creatives, :ad_groups

    def self.all(graph = Zuck.graph)
      super(graph)
    end

    def self.create(data, graph = Zuck.graph)
      super(graph, data)
    end

    def get_all(graph = Zuck.graph)
      raw_data = graph.batch do |batch_api|
        batch_api.get_object("#{id}/adcampaign_groups", fields: Zuck::AdCampaignGroup.fields.compact.join(','))
        batch_api.get_object("#{id}/adcampaigns", fields: Zuck::AdCampaign.fields.compact.join(','))
        batch_api.get_object("#{id}/adcreatives", fields: Zuck::AdCreative.fields.compact.join(','))
        batch_api.get_object("#{id}/adgroups", fields: Zuck::AdGroup.fields.compact.join(','))
        batch_api.get_object("#{id}/customaudiences", fields: Zuck::AdCustomAudience.fields.compact.join(','))
      end
      error = raw_data.find {|rd| rd.is_a?(StandardError)}
      return error unless error.nil?
      return {
          ad_campaign_groups: raw_data[0].map { |cg| Zuck::AdCampaignGroup.new(graph, cg) },
          ad_campaigns: raw_data[1].map { |c| Zuck::AdCampaign.new(graph, c) },
          ad_creatives: raw_data[2].map { |c| Zuck::AdCreative.new(graph, c) },
          ad_groups: raw_data[3].map { |ag| Zuck::AdGroup.new(graph, ag) },
          ad_custom_audiences: raw_data[4].map { |ca| Zuck::AdCustomAudience.new(graph, ca) }
      }
    end

    def get_tracking_specs(graph = Zuck.graph)
      return graph.get_object("#{id}/offsitepixels")
    end

    def get_ad_statistics(ad_group_ids, start_time, graph = Zuck.graph)
      graph_data = graph.get_object("#{id}/stats?ids=#{ad_group_ids}&start_time=#{start_time}", fields: Zuck::AdStatistic.fields.compact.join(','))
      if (graph_data && graph_data.size > 0)
        Hash[graph_data.map { |id, ad_group_stats| [ id, Zuck::AdStatistic.new(graph, ad_group_stats) ] }]
      else
        return nil
      end
    end
  end
end
