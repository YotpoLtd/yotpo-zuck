module Zuck
  class AdCustomAudience < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/custom-audience-targeting

    fields :id,
           :name,
           :subtype,
           :lookalike_spec


    parent_object :ad_account
    list_path     :customaudiences
  end
end