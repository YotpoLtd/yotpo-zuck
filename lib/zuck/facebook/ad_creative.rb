module Zuck
  class AdCreative < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/adcreative

    fields :id,
           :name,
           :title,
           :body,
           :object_url,
           :image_hash,
           :image_url,
           :call_to_action_type,
           :actor_id,
           :object_story_spec

    update_fields :name

    parent_object :ad_account
    list_path     :adcreatives
  end
end